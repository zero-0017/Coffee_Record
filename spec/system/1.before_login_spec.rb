# frozen_string_literal: true

require "rails_helper"

describe "会員ログイン前のテスト" do
  describe "トップ画面のテスト" do
    before do
      visit root_path
    end

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/"
      end
      it "ゲストログインリンクが表示される: 白色のボタンの表示が「ゲストログイン（閲覧用）」である" do
        guest_link = find_all("a")[1].native.inner_text
        expect(guest_link).to match(/ゲストログイン（閲覧用）/)
      end
      it "新規登録リンクが表示される: 灰色のボタンの表示が「新規登録」である" do
        sign_up_link = find_all("a")[2].native.inner_text
        expect(sign_up_link).to match(/新規登録/)
      end
      it "ログインリンクが表示される: スミクロ色のボタンの表示が「ログイン」である" do
        log_in_link = find_all("a")[3].native.inner_text
        expect(log_in_link).to match(/ログイン/)
      end
    end
  end

  describe "ヘッダーのテスト: ログインしていない場合" do
    before do
      visit root_path
    end

    context "表示内容の確認" do
      it "ホームリンクが表示される: 左上から1番目のリンクが「ロゴ」である" do
        home_link = find_all("a")[0].native.inner_text
        expect(home_link).to match(//)
      end
      it "ゲストログインリンクが表示される: 左上から2番目のリンクが「ゲストログイン（閲覧用）」である" do
        guest_link = find_all("a")[1].native.inner_text
        expect(guest_link).to match(/ゲストログイン（閲覧用）/)
      end
      it "新規登録リンクが表示される: 左上から3番目のリンクが「新規登録」である" do
        signup_link = find_all("a")[2].native.inner_text
        expect(signup_link).to match(/新規登録/)
      end
      it "ログインリンクが表示される: 左上から4番目のリンクが「ログイン」である" do
        login_link = find_all("a")[3].native.inner_text
        expect(login_link).to match(/ログイン/)
      end
    end

    context "リンクの内容を確認" do
      subject { current_path }

      it "ロゴ画像を押すと、トップ画面に遷移する" do
        home_link = find_all("a")[0].native.inner_text
        home_link = home_link.delete("")
        home_link.delete!("\n")
        click_link home_link
        is_expected.to eq "/"
      end
      it "ゲストログイン（閲覧）を押すと、アバウト画面に遷移する" do
        guest_link = find_all("a")[1].native.inner_text
        guest_link = guest_link.delete("\n").gsub(/\A\s*/, "").gsub(/\s*\Z/, "")
        click_link guest_link, match: :first
        is_expected.to eq "/about"
      end
      it "新規登録を押すと、新規登録画面に遷移する" do
        signup_link = find_all("a")[2].native.inner_text
        signup_link = signup_link.delete("\n").gsub(/\A\s*/, "").gsub(/\s*\Z/, "")
        click_link signup_link, match: :first
        is_expected.to eq "/users/sign_up"
      end
      it "ログインを押すと、ログイン画面に遷移する" do
        login_link = find_all("a")[3].native.inner_text
        login_link = login_link.delete("\n").gsub(/\A\s*/, "").gsub(/\s*\Z/, "")
        click_link login_link, match: :prefer_exact
        is_expected.to eq "/users/sign_in"
      end
    end
  end

  describe "会員新規登録のテスト" do
    before do
      visit new_user_registration_path
    end

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/users/sign_up"
      end
      it "「新規登録」と表示される" do
        expect(page).to have_content "新規登録"
      end
      it "会員名フォームが表示される" do
        expect(page).to have_field "user[name]"
      end
      it "メールアドレスフォームが表示される" do
        expect(page).to have_field "user[email]"
      end
      it "パスワードフォームが表示される" do
        expect(page).to have_field "user[password]"
      end
      it "パスワード 確認用フォームが表示される" do
        expect(page).to have_field "user[password_confirmation]"
      end
      it "新規登録ボタンが表示される" do
        expect(page).to have_button "新規登録"
      end
    end

    context "新規登録成功のテスト" do
      before do
        fill_in "user[name]", with: Faker::Lorem.characters(number: 10)
        fill_in "user[email]", with: Faker::Internet.email
        fill_in "user[password]", with: "password"
        fill_in "user[password_confirmation]", with: "password"
      end

      it "正しく新規登録される" do
        expect { click_button "新規登録" }.to change(User.all, :count).by(1)
      end
      it "新規登録後のリダイレクト先が、新規登録できたユーザの詳細画面になっている" do
        click_button "新規登録"
        expect(current_path).to eq "/users/" + User.last.id.to_s
      end
    end
  end

  describe "会員ログイン" do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
    end

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/users/sign_in"
      end
      it "「ログイン」と表示される" do
        expect(page).to have_content "ログイン"
      end
      it "メールアドレスフォームは表示される" do
        expect(page).to have_field "user[email]"
      end
      it "パスワードフォームが表示される" do
        expect(page).to have_field "user[password]"
      end
      it "ログインボタンが表示される" do
        expect(page).to have_button "ログイン"
      end
    end

    context "ログイン成功のテスト" do
      before do
        fill_in "user[email]", with: user.email
        fill_in "user[password]", with: user.password
        click_button "ログイン"
      end

      it "ログイン後のリダイレクト先が、アバウト画面になっている" do
        expect(current_path).to eq "/about"
      end
    end

    context "ログイン失敗のテスト" do
      before do
        fill_in "user[email]", with: ""
        fill_in "user[password]", with: ""
        click_button "ログイン"
      end

      it "ログインに失敗し、ログイン画面にリダイレクトされる" do
        expect(current_path).to eq "/users/sign_in"
      end
    end
  end

  describe "ヘッダーのテスト: ログインしている場合" do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_button "ログイン"
    end

    context "ヘッダーの表示を確認" do
      it "アバウトリンクが表示される: 左上から1番目のリンクが「ロゴ」である" do
        about_link = find_all("a")[0].native.inner_text
        expect(about_link).to match(//)
      end
      it "会員詳細リンクが表示される: 左上から2番目のリンクが「マイページ」である" do
        user_link = find_all("a")[1].native.inner_text
        expect(user_link).to match(/マイページ/)
      end
      it "会員一覧リンクが表示される: 左上から3番目のリンクが「会員一覧」である" do
        users_link = find_all("a")[2].native.inner_text
        expect(users_link).to match(/会員一覧/)
      end
      it "新規投稿リンクが表示される: 左上から4番目のリンクが「新規投稿」である" do
        post_coffee_link = find_all("a")[3].native.inner_text
        expect(post_coffee_link).to match(/新規投稿/)
      end
      it "投稿一覧リンクが表示される: 左上から4番目のリンクが「投稿一覧」である" do
        post_coffees_link = find_all("a")[4].native.inner_text
        expect(post_coffees_link).to match(/投稿一覧/)
      end
      it "ログアウトリンクが表示される: 左上から5番目のリンクが「ログアウト」である" do
        logout_link = find_all("a")[5].native.inner_text
        expect(logout_link).to match(/ログアウト/)
      end
    end
  end

  describe "会員ログアウトのテスト" do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_button "ログイン"
      logout_link = find_all("a")[5].native.inner_text
      logout_link = logout_link.delete("\n").gsub(/\A\s*/, "").gsub(/\s*\Z/, "")
      click_link logout_link
    end

    context "ログアウト機能のテスト" do
      it "正しくログアウトできている: ログアウト後のリダイレクト先においてゲストログインのリンクが存在する" do
        expect(page).to have_link "", href: "/users/guest_sign_in"
      end
      it "正しくログアウトできている: ログアウト後のリダイレクト先において新規登録画面へのリンクが存在する" do
        expect(page).to have_link "", href: "/users/sign_up"
      end
      it "正しくログアウトできている: ログアウト後のリダイレクト先においてログイン画面へのリンクが存在する" do
        expect(page).to have_link "", href: "/users/sign_in"
      end
      it "ログアウト後のリダイレクト先が、トップ画面になっている" do
        expect(current_path).to eq "/"
      end
    end
  end

  describe "管理者ログイン" do
    let(:admin) { create(:admin) }

    before do
      visit new_admin_session_path
    end

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/admin/sign_in"
      end
      it "「ログイン」と表示される" do
        expect(page).to have_content "ログイン"
      end
      it "メールアドレスフォームは表示される" do
        expect(page).to have_field "admin[email]"
      end
      it "パスワードフォームが表示される" do
        expect(page).to have_field "admin[password]"
      end
      it "ログインボタンが表示される" do
        expect(page).to have_button "ログイン"
      end
    end

    context "ログイン成功のテスト" do
      before do
        fill_in "admin[email]", with: admin.email
        fill_in "admin[password]", with: admin.password
        click_button "ログイン"
      end

      it "ログイン後のリダイレクト先が、管理者トップ画面になっている" do
        expect(current_path).to eq "/admin"
      end
    end

    context "ログイン失敗のテスト" do
      before do
        fill_in "admin[email]", with: ""
        fill_in "admin[password]", with: ""
        click_button "ログイン"
      end

      it "ログインに失敗し、ログイン画面にリダイレクトされる" do
        expect(current_path).to eq "/admin/sign_in"
      end
    end
  end

  describe "ヘッダーのテスト: ログインしている場合" do
    let(:admin) { create(:admin) }

    before do
      visit new_admin_session_path
      fill_in "admin[email]", with: admin.email
      fill_in "admin[password]", with: admin.password
      click_button "ログイン"
    end

    context "ヘッダーの表示を確認" do
      it "アバウトリンクが表示される: 左上から1番目のリンクが「ロゴ」である" do
        top_link = find_all("a")[0].native.inner_text
        expect(top_link).to match(//)
      end
      it "お問い合わせ一覧リンクが表示される: 左上から2番目のリンクが「お問い合わせ一覧」である" do
        contact_link = find_all("a")[1].native.inner_text
        expect(contact_link).to match(/お問い合わせ一覧/)
      end
      it "会員一覧リンクが表示される: 左上から3番目のリンクが「会員一覧」である" do
        users_link = find_all("a")[2].native.inner_text
        expect(users_link).to match(/会員一覧/)
      end
      it "投稿一覧リンクが表示される: 左上から4番目のリンクが「投稿一覧」である" do
        post_coffee_link = find_all("a")[3].native.inner_text
        expect(post_coffee_link).to match(/投稿一覧/)
      end
      it "コメント一覧リンクが表示される: 左上から4番目のリンクが「コメント一覧」である" do
        coffee_comment_link = find_all("a")[4].native.inner_text
        expect(coffee_comment_link).to match(/コメント一覧/)
      end
      it "ログアウトリンクが表示される: 左上から5番目のリンクが「ログアウト」である" do
        logout_link = find_all("a")[5].native.inner_text
        expect(logout_link).to match(/ログアウト/)
      end
    end
  end

  describe "管理者ログアウトのテスト" do
    let(:admin) { create(:admin) }

    before do
      visit new_admin_session_path
      fill_in "admin[email]", with: admin.email
      fill_in "admin[password]", with: admin.password
      click_button "ログイン"
      logout_link = find_all("a")[5].native.inner_text
      logout_link = logout_link.delete("\n").gsub(/\A\s*/, "").gsub(/\s*\Z/, "")
      click_link logout_link
    end

    context "ログアウト機能のテスト" do
      it "正しくログアウトできている: ログアウト後のリダイレクト先においてゲストログインのリンクが存在する" do
        expect(page).to have_link "", href: "/users/guest_sign_in"
      end
      it "正しくログアウトできている: ログアウト後のリダイレクト先において新規登録画面へのリンクが存在する" do
        expect(page).to have_link "", href: "/users/sign_up"
      end
      it "正しくログアウトできている: ログアウト後のリダイレクト先においてログイン画面へのリンクが存在する" do
        expect(page).to have_link "", href: "/users/sign_in"
      end
      it "ログアウト後のリダイレクト先が、トップ画面になっている" do
        expect(current_path).to eq "/admin/sign_in"
      end
    end
  end
end

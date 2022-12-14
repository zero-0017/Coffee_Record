# frozen_string_literal: true

require "rails_helper"

describe "仕上げのテスト" do
  let(:user) { create(:user) }
  let(:coffee_brew) { create(:coffee_brew) }
  let(:coffee) { create(:coffee) }
  let(:coffee_bean) { create(:coffee_bean) }
  let!(:other_user) { create(:user) }
  let!(:post_coffee) { create(:post_coffee, user: user) }
  let!(:other_post_coffee) { create(:post_coffee, user: other_user) }
  let!(:contact) { create(:contact, user: user) }

  describe "フラッシュメッセージのテスト" do
    subject { page }

    it "会員新規登録成功時" do
      visit new_user_registration_path
      fill_in "user[name]", with: Faker::Lorem.characters(number: 9)
      fill_in "user[email]", with: "a" + user.email
      fill_in "user[password]", with: "password"
      fill_in "user[password_confirmation]", with: "password"
      click_button "新規登録"
      is_expected.to have_content "アカウント登録が完了しました。"
    end
    it "会員ログイン成功時" do
      visit new_user_session_path
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_button "ログイン"
      is_expected.to have_content "ログインしました"
    end
    it "会員ログアウト成功時" do
      visit new_user_session_path
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_button "ログイン"
      logout_link = find_all("a")[5].native.inner_text
      logout_link = logout_link.delete("\n").gsub(/\A\s*/, "").gsub(/\s*\Z/, "")
      click_link logout_link
      is_expected.to have_content "ログアウトしました。"
    end
    it "会員の情報更新成功時" do
      visit new_user_session_path
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_button "ログイン"
      visit edit_user_path(user)
      click_button "変更内容保存"
      is_expected.to have_content "会員情報の変更内容を保存しました"
    end
    it "投稿データの更新成功時" do
      visit new_user_session_path
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_button "ログイン"
      visit edit_post_coffee_path(post_coffee)
      click_button "変更内容保存"
      is_expected.to have_content "投稿の変更内容を保存しました"
    end
    it "投稿データの削除成功時" do
      visit new_user_session_path
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_button "ログイン"
      visit post_coffee_path(post_coffee)
      click_on "削除"
      is_expected.to have_content "投稿を削除しました"
    end
    it "お問い合わせデータの新規お問い合わせ成功時" do
      visit new_user_session_path
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_button "ログイン"
      visit new_contact_path(contact)
      fill_in "contact[content]", with: Faker::Lorem.characters(number: 5)
      click_button "送信"
      is_expected.to have_content "お問い合わせが完了しました"
    end
    it "お問い合わせデータの削除成功時" do
      visit new_user_session_path
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_button "ログイン"
      visit contact_path(contact)
      click_on "削除"
      is_expected.to have_content "お問い合わせを削除しました"
    end
    it "通知データの削除成功時" do
      visit new_user_session_path
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_button "ログイン"
      visit notifications_path
      click_on "削除"
      is_expected.to have_content "通知を全て削除しました"
    end
  end

  describe "処理失敗時のテスト" do
    context "会員新規登録失敗: nameを0文字にする" do
      before do
        visit new_user_registration_path
        @name = Faker::Lorem.characters(number: 0)
        @email = "a" + user.email
        fill_in "user[name]", with: @name
        fill_in "user[email]", with: @email
        fill_in "user[password]", with: "password"
        fill_in "user[password_confirmation]", with: "password"
      end

      it "新規登録されない" do
        expect { click_button "新規登録" }.not_to change(User.all, :count)
      end
      it "新規登録画面を表示しており、フォームの内容が正しい" do
        click_button "新規登録"
        expect(page).to have_content "新規登録"
        expect(page).to have_field "user[name]", with: @name
        expect(page).to have_field "user[email]", with: @email
      end
      it "バリデーションエラーが表示される" do
        click_button "新規登録"
        expect(page).to have_content "会員名を入力してください"
      end
    end

    context "会員のプロフィール情報編集失敗: 会員名を0文字にする" do
      before do
        @user_old_name = user.name
        @name = Faker::Lorem.characters(number: 0)
        visit new_user_session_path
        fill_in "user[email]", with: user.email
        fill_in "user[password]", with: user.password
        click_button "ログイン"
        visit edit_user_path(user)
        fill_in "user[name]", with: @name
        click_button "変更内容保存"
      end

      it "更新されない" do
        expect(user.reload.name).to eq @user_old_name
      end
      it "会員編集画面を表示しており、フォームの内容が正しい" do
        expect(page).to have_field "user[name]", with: @name
      end
      it "バリデーションエラーが表示される" do
        expect(page).to have_content "会員名を入力してください"
      end
    end

    context "投稿データの新規投稿失敗: 投稿名を空にする" do
      before do
        visit new_user_session_path
        fill_in "user[email]", with: user.email
        fill_in "user[password]", with: user.password
        click_button "ログイン"
        visit new_post_coffee_path
        @post_coffee = Faker::Lorem.characters(number: 0)
        fill_in "post_coffee[post_name]", with: @post_coffee
      end

      it "投稿が保存されない" do
        expect { click_button "新規投稿" }.not_to change(PostCoffee.all, :count)
      end
      it "新規投稿フォームの内容が正しい" do
        expect(find_field("post_coffee[post_name]").text).to be_blank
        expect(page).to have_field "post_coffee[post_name]", with: @post_coffee
      end
      it "バリデーションエラーが表示される" do
        click_button "新規投稿"
        expect(page).to have_content "投稿名を入力してください"
      end
    end

    context "投稿データの更新失敗: 投稿名を空にする" do
      before do
        visit new_user_session_path
        fill_in "user[email]", with: user.email
        fill_in "user[password]", with: user.password
        click_button "ログイン"
        visit edit_post_coffee_path(post_coffee)
        @post_coffee_old_post_name = post_coffee.post_name
        fill_in "post_coffee[post_name]", with: ""
        click_button "変更内容保存"
      end

      it "投稿が更新されない" do
        expect(post_coffee.reload.post_name).to eq @post_coffee_old_post_name
      end
      it "投稿編集画面を表示しており、フォームの内容が正しい" do
        expect(current_path).to eq "/post_coffees/" + post_coffee.id.to_s
        expect(find_field("post_coffee[post_name]").text).to be_blank
        expect(page).to have_field "post_coffee[post_name]", with: ""
      end
      it "エラーメッセージが表示される" do
        expect(page).to have_content "投稿名を入力してください"
      end
    end
  end

  describe "ログインしていない場合のアクセス制限のテスト: アクセスできず、会員ログイン画面に遷移する（会員側）" do
    subject { current_path }

    it "アバウト画面" do
      visit about_path
      is_expected.to eq "/users/sign_in"
    end
    it "会員一覧画面" do
      visit users_path
      is_expected.to eq "/users/sign_in"
    end
    it "会員詳細画面" do
      visit user_path(user)
      is_expected.to eq "/users/sign_in"
    end
    it "会員情報編集画面" do
      visit edit_user_path(user)
      is_expected.to eq "/users/sign_in"
    end
    it "会員退会確認画面" do
      visit unsubscribe_users_path
      is_expected.to eq "/users/sign_in"
    end
    it "お気に入り投稿一覧画面" do
      visit favorites_user_path(user)
      is_expected.to eq "/users/sign_in"
    end
    it "会員の投稿一覧画面" do
      visit post_list_user_path(user)
      is_expected.to eq "/users/sign_in"
    end
    it "下書き投稿一覧画面" do
      visit confirm_post_coffees_path
      is_expected.to eq "/users/sign_in"
    end
    it "フォロー一覧画面" do
      visit followings_user_path(user)
      is_expected.to eq "/users/sign_in"
    end
    it "フォロワー一覧画面" do
      visit followers_user_path(user)
      is_expected.to eq "/users/sign_in"
    end
    it "投稿一覧画面" do
      visit post_coffees_path
      is_expected.to eq "/users/sign_in"
    end
    it "新規投稿画面" do
      visit new_post_coffee_path
      is_expected.to eq "/users/sign_in"
    end
    it "投稿詳細画面" do
      visit post_coffee_path(post_coffee)
      is_expected.to eq "/users/sign_in"
    end
    it "投稿編集画面" do
      visit edit_post_coffee_path(post_coffee)
      is_expected.to eq "/users/sign_in"
    end
    it "通知一覧画面" do
      visit notifications_path
      is_expected.to eq "/users/sign_in"
    end
    it "お問い合わせ一覧画面" do
      visit contacts_path
      is_expected.to eq "/users/sign_in"
    end
    it "新規お問い合わせ画面" do
      visit new_contact_path
      is_expected.to eq "/users/sign_in"
    end
    it "お問い合わせ詳細画面" do
      visit contact_path(user)
      is_expected.to eq "/users/sign_in"
    end
    it "お問い合わせ完了画面" do
      visit thank_contacts_path
      is_expected.to eq "/users/sign_in"
    end
    it "投稿名検索詳細画面" do
      visit search_path
      is_expected.to eq "/users/sign_in"
    end
    it "珈琲の淹れ方名詳細画面" do
      visit coffee_brew_path(post_coffee)
      is_expected.to eq "/users/sign_in"
    end
    it "珈琲の種類名詳細画面" do
      visit coffee_path(post_coffee)
      is_expected.to eq "/users/sign_in"
    end
    it "珈琲豆の種類名詳細画面" do
      visit coffee_bean_path(post_coffee)
      is_expected.to eq "/users/sign_in"
    end
  end

  describe "ログインしていない場合のアクセス制限のテスト: アクセスできず、管理者ログイン画面に遷移する（管理者側）" do
    subject { current_path }

    it "管理者トップ画面" do
      visit admin_path
      is_expected.to eq "/admin/sign_in"
    end
    it "珈琲の淹れ方一覧画面" do
      visit admin_coffee_brews_path
      is_expected.to eq "/admin/sign_in"
    end
    it "珈琲の淹れ方編集画面" do
      visit edit_admin_coffee_brew_path(coffee_brew)
      is_expected.to eq "/admin/sign_in"
    end
    it "珈琲の種類一覧画面" do
      visit admin_coffees_path
      is_expected.to eq "/admin/sign_in"
    end
    it "珈琲の種類編集画面" do
      visit edit_admin_coffee_path(coffee)
      is_expected.to eq "/admin/sign_in"
    end
    it "珈琲豆の種類一覧画面" do
      visit admin_coffee_beans_path
      is_expected.to eq "/admin/sign_in"
    end
    it "珈琲豆の種類編集画面" do
      visit edit_admin_coffee_bean_path(coffee_bean)
      is_expected.to eq "/admin/sign_in"
    end
    it "会員一覧画面" do
      visit admin_users_path
      is_expected.to eq "/admin/sign_in"
    end
    it "会員詳細画面" do
      visit admin_user_path(user)
      is_expected.to eq "/admin/sign_in"
    end
    it "投稿一覧画面" do
      visit admin_post_coffees_path
      is_expected.to eq "/admin/sign_in"
    end
    it "投稿詳細画面" do
      visit admin_post_coffee_path(post_coffee)
      is_expected.to eq "/admin/sign_in"
    end
    it "お問い合わせ一覧画面" do
      visit admin_contacts_path
      is_expected.to eq "/admin/sign_in"
    end
    it "お問い合わせ詳細画面" do
      visit admin_contact_path(user)
      is_expected.to eq "/admin/sign_in"
    end
    it "コメント一覧画面" do
      visit admin_coffee_comments_path
      is_expected.to eq "/admin/sign_in"
    end
    it "検索詳細画面" do
      visit admin_search_path
      is_expected.to eq "/admin/sign_in"
    end
  end

  describe "他人の画面のテスト" do
    before do
      visit new_user_session_path
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_button "ログイン"
    end

    describe "他人の投稿詳細画面のテスト" do
      before do
        visit post_coffee_path(other_post_coffee)
      end

      context "表示内容の確認" do
        it "URLが正しい" do
          expect(current_path).to eq "/post_coffees/" + other_post_coffee.id.to_s
        end
        it "「投稿詳細」と表示される" do
          expect(page).to have_content "投稿詳細"
        end
        it "会員画像・名前のリンク先が正しい" do
          expect(page).to have_link other_post_coffee.user.name, href: user_path(other_post_coffee.user)
        end
        it "投稿の投稿名が表示される" do
          expect(page).to have_content other_post_coffee.post_name
        end
        it "投稿の珈琲の淹れ方が表示される" do
          expect(page).to have_content other_post_coffee.coffee_brew.coffee_brew_name
        end
        it "投稿の珈琲の種類が表示される" do
          expect(page).to have_content other_post_coffee.coffee.coffee_name
        end
        it "投稿の投稿説明が表示される" do
          expect(page).to have_content other_post_coffee.post_explanation
        end
        it "投稿の編集リンクが表示されない" do
          expect(page).not_to have_link "編集"
        end
        it "投稿の削除リンクが表示されない" do
          expect(page).not_to have_link "削除"
        end
      end
    end

    context "他人の投稿編集画面" do
      it "遷移できず、投稿一覧画面にリダイレクトされる" do
        visit edit_post_coffee_path(other_post_coffee)
        expect(current_path).to eq "/post_coffees"
      end
    end

    describe "他人の投稿一覧画面のテスト" do
      before do
        visit post_list_user_path(other_user)
      end

      context "表示の確認" do
        it "URLが正しい" do
          expect(current_path).to eq "/users/" + other_user.id.to_s + "/post_list"
        end
        it "投稿一覧の投稿画像のリンク先が正しい" do
          expect(page).to have_link "", href: post_coffee_path(other_post_coffee)
        end
        it "自分の投稿は表示されない" do
          expect(page).not_to have_content post_coffee.post_name
        end
      end
    end

    describe "他人のお気に入り投稿一覧画面のテスト" do
      before do
        visit favorites_user_path(other_user)
      end

      context "表示の確認" do
        it "URLが正しい" do
          expect(current_path).to eq "/users/" + other_user.id.to_s + "/favorites"
        end
      end
    end

    describe "他人のフォロー一覧画面のテスト" do
      before do
        visit followings_user_path(other_user)
      end

      context "表示の確認" do
        it "URLが正しい" do
          expect(current_path).to eq "/users/" + other_user.id.to_s + "/followings"
        end
      end
    end

    describe "他人のフォロワー一覧画面のテスト" do
      before do
        visit followers_user_path(other_user)
      end

      context "表示の確認" do
        it "URLが正しい" do
          expect(current_path).to eq "/users/" + other_user.id.to_s + "/followers"
        end
      end
    end

    context "他人の会員情報編集画面" do
      it "遷移できず、自分のマイページ画面にリダイレクトされる" do
        visit edit_user_path(other_user)
        expect(current_path).to eq "/users/" + user.id.to_s
      end
    end

    context "他人の投稿編集画面" do
      it "遷移できず、投稿一覧画面にリダイレクトされる" do
        visit edit_post_coffee_path(other_post_coffee)
        expect(current_path).to eq "/post_coffees"
      end
    end
  end
end

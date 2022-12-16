# frozen_string_literal: true

require "rails_helper"

describe "仕上げのテスト（管理者側）" do
  let(:admin) { create(:admin) }
  let(:user) { create(:user) }
  let(:coffee_brew) { create(:coffee_brew) }
  let(:coffee) { create(:coffee) }
  let(:coffee_bean) { create(:coffee_bean) }
  let(:post_coffee) { create(:post_coffee) }
  let(:coffee_comment) { create(:coffee_comment, user: user, post_coffee: post_coffee) }
  let(:contact) { create(:contact) }

  describe "フラッシュメッセージのテスト" do
    subject { page }

    it "管理者ログイン成功時" do
      visit new_admin_session_path
      fill_in "admin[email]", with: admin.email
      fill_in "admin[password]", with: admin.password
      click_button "ログイン"
      is_expected.to have_content "ログインしました"
    end
    it "管理者ログアウト成功時" do
      visit new_admin_session_path
      fill_in "admin[email]", with: admin.email
      fill_in "admin[password]", with: admin.password
      click_button "ログイン"
      logout_link = find_all("a")[5].native.inner_text
      logout_link = logout_link.delete("\n").gsub(/\A\s*/, "").gsub(/\s*\Z/, "")
      click_link logout_link
      is_expected.to have_content "ログアウトしました。"
    end
    it "会員の情報更新成功時" do
      visit new_admin_session_path
      fill_in "admin[email]", with: admin.email
      fill_in "admin[password]", with: admin.password
      click_button "ログイン"
      visit admin_user_path(user)
      click_button "変更内容保存"
      is_expected.to have_content "会員情報の変更内容を保存しました"
    end
    it "お問い合わせ内容更新成功時" do
      visit new_admin_session_path
      fill_in "admin[email]", with: admin.email
      fill_in "admin[password]", with: admin.password
      click_button "ログイン"
      visit admin_contact_path(contact)
      click_button "変更内容保存"
      is_expected.to have_content "対応状況の変更内容を保存しました"
    end
    it "投稿データの削除成功時" do
      visit new_admin_session_path
      fill_in "admin[email]", with: admin.email
      fill_in "admin[password]", with: admin.password
      click_button "ログイン"
      visit admin_post_coffee_path(post_coffee)
      click_on "削除"
      is_expected.to have_content "投稿を削除しました"
    end
    it "珈琲の淹れ方データの新規登録成功時" do
      visit new_admin_session_path
      fill_in "admin[email]", with: admin.email
      fill_in "admin[password]", with: admin.password
      click_button "ログイン"
      visit admin_coffee_brews_path(coffee_brew)
      fill_in "coffee_brew[coffee_brew_name]", with: Faker::Lorem.characters(number: 5)
      click_on "新規登録"
      is_expected.to have_content "珈琲の淹れ方名を作成しました"
    end
    it "珈琲の淹れ方データの変更内容保存成功時" do
      visit new_admin_session_path
      fill_in "admin[email]", with: admin.email
      fill_in "admin[password]", with: admin.password
      click_button "ログイン"
      visit edit_admin_coffee_brew_path(coffee_brew)
      fill_in "coffee_brew[coffee_brew_name]", with: Faker::Lorem.characters(number: 7)
      click_on "変更内容保存"
      is_expected.to have_content "珈琲の淹れ方名の変更内容を保存しました"
    end
    it "珈琲の淹れ方データの削除成功時" do
      visit new_admin_session_path
      fill_in "admin[email]", with: admin.email
      fill_in "admin[password]", with: admin.password
      click_button "ログイン"
      visit edit_admin_coffee_brew_path(coffee_brew)
      click_on "削除"
      is_expected.to have_content "珈琲の淹れ方名を削除しました"
    end
    it "珈琲の種類データの新規登録成功時" do
      visit new_admin_session_path
      fill_in "admin[email]", with: admin.email
      fill_in "admin[password]", with: admin.password
      click_button "ログイン"
      visit admin_coffees_path(coffee)
      fill_in "coffee[coffee_name]", with: Faker::Lorem.characters(number: 5)
      click_on "新規登録"
      is_expected.to have_content "珈琲の種類名を作成しました"
    end
    it "珈琲の種類データの変更内容保存成功時" do
      visit new_admin_session_path
      fill_in "admin[email]", with: admin.email
      fill_in "admin[password]", with: admin.password
      click_button "ログイン"
      visit edit_admin_coffee_path(coffee)
      fill_in "coffee[coffee_name]", with: Faker::Lorem.characters(number: 7)
      click_on "変更内容保存"
      is_expected.to have_content "珈琲の種類名の変更内容を保存しました"
    end
    it "珈琲の種類データの削除成功時" do
      visit new_admin_session_path
      fill_in "admin[email]", with: admin.email
      fill_in "admin[password]", with: admin.password
      click_button "ログイン"
      visit edit_admin_coffee_path(coffee)
      click_on "削除"
      is_expected.to have_content "珈琲の種類名を削除しました"
    end
    it "珈琲豆の種類データの新規登録成功時" do
      visit new_admin_session_path
      fill_in "admin[email]", with: admin.email
      fill_in "admin[password]", with: admin.password
      click_button "ログイン"
      visit admin_coffee_beans_path(coffee_bean)
      fill_in "coffee_bean[coffee_bean_name]", with: Faker::Lorem.characters(number: 5)
      click_on "新規登録"
      is_expected.to have_content "珈琲豆の種類名を作成しました"
    end
    it "珈琲豆の種類データの変更内容保存成功時" do
      visit new_admin_session_path
      fill_in "admin[email]", with: admin.email
      fill_in "admin[password]", with: admin.password
      click_button "ログイン"
      visit edit_admin_coffee_bean_path(coffee_bean)
      fill_in "coffee_bean[coffee_bean_name]", with: Faker::Lorem.characters(number: 7)
      click_on "変更内容保存"
      is_expected.to have_content "珈琲豆の種類名の変更内容を保存しました"
    end
    it "珈琲豆の種類データの削除成功時" do
      visit new_admin_session_path
      fill_in "admin[email]", with: admin.email
      fill_in "admin[password]", with: admin.password
      click_button "ログイン"
      visit edit_admin_coffee_bean_path(coffee_bean)
      click_on "削除"
      is_expected.to have_content "珈琲豆の種類名を削除しました"
    end
    it "コメントデータの削除成功時" do
      visit new_admin_session_path
      fill_in "admin[email]", with: admin.email
      fill_in "admin[password]", with: admin.password
      click_button "ログイン"
      visit admin_coffee_comments_path(coffee_comment)
      click_on "削除"
      is_expected.to have_content "コメントを削除しました"
    end
  end

  describe "処理失敗時のテスト" do
    context "珈琲の淹れ方データの新規登録失敗: 珈琲の淹れ方名を空にする" do
      before do
        visit new_admin_session_path
        fill_in "admin[email]", with: admin.email
        fill_in "admin[password]", with: admin.password
        click_button "ログイン"
        visit admin_coffee_brews_path(coffee_brew)
        @coffee_brew = Faker::Lorem.characters(number: 0)
        fill_in "coffee_brew[coffee_brew_name]", with: @coffee_brew
      end

      it "珈琲の淹れ方名が保存されない" do
        expect { click_button "新規登録" }.not_to change(CoffeeBrew.all, :count)
      end
      it "珈琲の淹れ方名フォームの内容が正しい" do
        expect(find_field("coffee_brew[coffee_brew_name]").text).to be_blank
        expect(page).to have_field "coffee_brew[coffee_brew_name]", with: @coffee_brew
      end
      it "バリデーションエラーが表示される" do
        click_button "新規登録"
        expect(page).to have_content "珈琲の淹れ方を入力してください"
      end
    end

    context "珈琲の淹れ方名の更新失敗: 珈琲の淹れ方名を空にする" do
      before do
        visit new_admin_session_path
        fill_in "admin[email]", with: admin.email
        fill_in "admin[password]", with: admin.password
        click_button "ログイン"
        visit edit_admin_coffee_brew_path(coffee_brew)
        @coffee_brew_old_coffee_brew_name = coffee_brew.coffee_brew_name
        fill_in "coffee_brew[coffee_brew_name]", with: ""
        click_button "変更内容保存"
      end

      it "珈琲の淹れ方名が更新されない" do
        expect(coffee_brew.reload.coffee_brew_name).to eq @coffee_brew_old_coffee_brew_name
      end
      it "珈琲の淹れ方名編集画面を表示しており、フォームの内容が正しい" do
        expect(current_path).to eq "/admin/coffee_brews/" + coffee_brew.id.to_s
        expect(find_field("coffee_brew[coffee_brew_name]").text).to be_blank
        expect(page).to have_field "coffee_brew[coffee_brew_name]", with: ""
      end
      it "エラーメッセージが表示される" do
        expect(page).to have_content "珈琲の淹れ方を入力してください"
      end
    end

    context "珈琲の種類データの新規登録失敗: 珈琲の種類名を空にする" do
      before do
        visit new_admin_session_path
        fill_in "admin[email]", with: admin.email
        fill_in "admin[password]", with: admin.password
        click_button "ログイン"
        visit admin_coffees_path(coffee)
        @coffee = Faker::Lorem.characters(number: 0)
        fill_in "coffee[coffee_name]", with: @coffee
      end

      it "珈琲の種類名が保存されない" do
        expect { click_button "新規登録" }.not_to change(Coffee.all, :count)
      end
      it "珈琲の種類名フォームの内容が正しい" do
        expect(find_field("coffee[coffee_name]").text).to be_blank
        expect(page).to have_field "coffee[coffee_name]", with: @coffee
      end
      it "バリデーションエラーが表示される" do
        click_button "新規登録"
        expect(page).to have_content "珈琲の種類を入力してください"
      end
    end

    context "珈琲の種類の更新失敗: 珈琲の種類名を空にする" do
      before do
        visit new_admin_session_path
        fill_in "admin[email]", with: admin.email
        fill_in "admin[password]", with: admin.password
        click_button "ログイン"
        visit edit_admin_coffee_path(coffee)
        @coffee_old_coffee_name = coffee.coffee_name
        fill_in "coffee[coffee_name]", with: ""
        click_button "変更内容保存"
      end

      it "珈琲の種類名が更新されない" do
        expect(coffee.reload.coffee_name).to eq @coffee_old_coffee_name
      end
      it "珈琲の種類名編集画面を表示しており、フォームの内容が正しい" do
        expect(current_path).to eq "/admin/coffees/" + coffee.id.to_s
        expect(find_field("coffee[coffee_name]").text).to be_blank
        expect(page).to have_field "coffee[coffee_name]", with: ""
      end
      it "エラーメッセージが表示される" do
        expect(page).to have_content "珈琲の種類を入力してください"
      end
    end

    context "珈琲豆の種類データの新規登録失敗: 珈琲豆の種類名を空にする" do
      before do
        visit new_admin_session_path
        fill_in "admin[email]", with: admin.email
        fill_in "admin[password]", with: admin.password
        click_button "ログイン"
        visit admin_coffee_beans_path(coffee_bean)
        @coffee_brew = Faker::Lorem.characters(number: 0)
        fill_in "coffee_bean[coffee_bean_name]", with: @coffee_bean
      end

      it "珈琲豆の種類名が保存されない" do
        expect { click_button "新規登録" }.not_to change(CoffeeBean.all, :count)
      end
      it "珈琲豆の種類名フォームの内容が正しい" do
        expect(find_field("coffee_bean[coffee_bean_name]").text).to be_blank
        expect(page).to have_field "coffee_bean[coffee_bean_name]", with: @coffee_bean
      end
      it "バリデーションエラーが表示される" do
        click_button "新規登録"
        expect(page).to have_content "珈琲豆の種類を入力してください"
      end
    end

    context "珈琲豆の種類名の更新失敗: 珈琲豆の種類名を空にする" do
      before do
        visit new_admin_session_path
        fill_in "admin[email]", with: admin.email
        fill_in "admin[password]", with: admin.password
        click_button "ログイン"
        visit edit_admin_coffee_bean_path(coffee_bean)
        @coffee_bean_old_coffee_bean_name = coffee_bean.coffee_bean_name
        fill_in "coffee_bean[coffee_bean_name]", with: ""
        click_button "変更内容保存"
      end

      it "珈琲豆の種類名が更新されない" do
        expect(coffee_bean.reload.coffee_bean_name).to eq @coffee_bean_old_coffee_bean_name
      end
      it "珈琲豆の種類名編集画面を表示しており、フォームの内容が正しい" do
        expect(current_path).to eq "/admin/coffee_beans/" + coffee_bean.id.to_s
        expect(find_field("coffee_bean[coffee_bean_name]").text).to be_blank
        expect(page).to have_field "coffee_bean[coffee_bean_name]", with: ""
      end
      it "エラーメッセージが表示される" do
        expect(page).to have_content "珈琲豆の種類を入力してください"
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

describe '仕上げのテスト' do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:post_coffee) { create(:post_coffee, user: user) }
  let!(:other_post_coffee) { create(:post_coffee, user: other_user) }

  describe 'サクセスメッセージのテスト' do
    subject { page }

    it '会員新規登録成功時' do
      visit new_user_registration_path
      fill_in 'user[name]', with: Faker::Lorem.characters(number: 9)
      fill_in 'user[email]', with: 'a' + user.email # 確実にuser, other_userと違う文字列にするため
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button '新規登録'
      is_expected.to have_content 'アカウント登録が完了しました。'
    end
    it '会員ログイン成功時' do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
      is_expected.to have_content 'ログインしました'
    end
    it '会員ログアウト成功時' do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
      logout_link = find_all('a')[5].native.inner_text
      logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link logout_link
      is_expected.to have_content 'ログアウトしました。'
    end
    it '会員の情報更新成功時' do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
      visit edit_user_path(user)
      click_button '変更内容保存'
      is_expected.to have_content '会員情報の変更内容を保存しました'
    end
    # it '投稿データの新規投稿成功時: 投稿一覧画面から行います。' do
    #   visit new_user_session_path
    #   fill_in 'user[email]', with: user.email
    #   fill_in 'user[password]', with: user.password
    #   click_button 'ログイン'
    #   visit new_post_coffee_path
    #   fill_in 'post_coffee[post_name]', with: Faker::Lorem.characters(number: 25)
    #   fill_in 'post_coffee[post_explanation]', with: Faker::Lorem.characters(number: 20)
    #   fill_in 'post_coffee[coffee_brew_id]', with: FactoryBot.create(:coffee_brew).id
    #   fill_in 'coffee[coffee_name]', with: FactoryBot.create(:coffee).id
    #   fill_in 'coffee_bean_ids[coffee_bean_name]', with: FactoryBot.create(:coffee_bean).id
    #   click_button '新規投稿'
    #   is_expected.to have_content '投稿しました'
    # end
    it '投稿データの更新成功時' do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
      visit edit_post_coffee_path(post_coffee)
      click_button '変更内容保存'
      is_expected.to have_content '投稿の変更内容を保存しました'
    end
  end

  describe '処理失敗時のテスト' do
    context '会員新規登録失敗: nameを0文字にする' do
      before do
        visit new_user_registration_path
        @name = Faker::Lorem.characters(number: 0)
        @email = 'a' + user.email # 確実にuser, other_userと違う文字列にするため
        fill_in 'user[name]', with: @name
        fill_in 'user[email]', with: @email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
      end

      it '新規登録されない' do
        expect { click_button '新規登録' }.not_to change(User.all, :count)
      end
      it '新規登録画面を表示しており、フォームの内容が正しい' do
        click_button '新規登録'
        expect(page).to have_content '新規登録'
        expect(page).to have_field 'user[name]', with: @name
        expect(page).to have_field 'user[email]', with: @email
      end
      it 'バリデーションエラーが表示される' do
        click_button '新規登録'
        expect(page).to have_content "会員名を入力してください"
      end
    end

    context 'ユーザのプロフィール情報編集失敗: nameを0文字にする' do
      before do
        @user_old_name = user.name
        @name = Faker::Lorem.characters(number: 0)
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
        visit edit_user_path(user)
        fill_in 'user[name]', with: @name
        click_button '変更内容保存'
      end

      it '更新されない' do
        expect(user.reload.name).to eq @user_old_name
      end
      it '会員編集画面を表示しており、フォームの内容が正しい' do
        expect(page).to have_field 'user[name]', with: @name
      end
      it 'バリデーションエラーが表示される' do
        expect(page).to have_content "会員名を入力してください"
      end
    end

    context '投稿データの新規投稿失敗: 投稿名を空にする' do
      before do
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
        visit new_post_coffee_path
        @post_coffee = Faker::Lorem.characters(number: 0)
        fill_in 'post_coffee[post_name]', with: @post_coffee
      end

      it '投稿が保存されない' do
        expect { click_button '新規投稿' }.not_to change(PostCoffee.all, :count)
      end
      it '新規投稿フォームの内容が正しい' do
        expect(find_field('post_coffee[post_name]').text).to be_blank
        expect(page).to have_field 'post_coffee[post_name]', with: @post_coffee
      end
      it 'バリデーションエラーが表示される' do
        click_button '新規投稿'
        expect(page).to have_content "投稿名を入力してください"
      end
    end

    context '投稿データの更新失敗: 投稿名を空にする' do
      before do
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
        visit edit_post_coffee_path(post_coffee)
        @post_coffee_old_post_name = post_coffee.post_name
        fill_in 'post_coffee[post_name]', with: ''
        click_button '変更内容保存'
      end

      it '投稿が更新されない' do
        expect(post_coffee.reload.post_name).to eq @post_coffee_old_post_name
      end
      it '投稿編集画面を表示しており、フォームの内容が正しい' do
        expect(current_path).to eq '/post_coffees/' + post_coffee.id.to_s
        expect(find_field('post_coffee[post_name]').text).to be_blank
        expect(page).to have_field 'post_coffee[post_name]', with: ''
      end
      it 'エラーメッセージが表示される' do
        expect(page).to have_content '投稿名を入力してください'
      end
    end
  end

  describe 'ログインしていない場合のアクセス制限のテスト: アクセスできず、ログイン画面に遷移する' do
    subject { current_path }

    it '会員一覧画面' do
      visit users_path
      is_expected.to eq '/users/sign_in'
    end
    it '会員詳細画面' do
      visit user_path(user)
      is_expected.to eq '/users/sign_in'
    end
    it '会員情報編集画面' do
      visit edit_user_path(user)
      is_expected.to eq '/users/sign_in'
    end
    it '会員退会確認画面' do
      visit unsubscribe_users_path
      is_expected.to eq '/users/sign_in'
    end
    it '会員退会画面' do
      visit withdrawal_users_path
      is_expected.to eq '/users/sign_in'
    end
    it '会員の投稿一覧画面' do
      visit post_coffees_path
      is_expected.to eq '/users/sign_in'
    end
    it '下書き投稿一覧画面' do
      visit confirm_post_coffees_path
      is_expected.to eq '/users/sign_in'
    end
    it 'フォロー一覧画面' do
      visit followings_user_path(followings_user)
      is_expected.to eq '/users/sign_in'
    end
    it 'フォロワー一覧画面' do
      visit followers_user_path(followers_user)
      is_expected.to eq '/users/sign_in'
    end
    it '投稿一覧画面' do
      visit post_coffees_path
      is_expected.to eq '/users/sign_in'
    end
    it '新規投稿画面' do
      visit new_post_coffee_path
      is_expected.to eq '/users/sign_in'
    end
    it '投稿詳細画面' do
      visit post_coffee_path(post_coffee)
      is_expected.to eq '/users/sign_in'
    end
    it '投稿編集画面' do
      visit edit_post_coffee_path(post_coffee)
      is_expected.to eq '/users/sign_in'
    end
    it 'お問い合わせ一覧画面' do
      visit contacts_path
      is_expected.to eq '/users/sign_in'
    end
    it '新規お問い合わせ画面' do
      visit new_contact_path
      is_expected.to eq '/users/sign_in'
    end
    it 'お問い合わせ詳細画面' do
      visit contact_path(contact)
      is_expected.to eq '/users/sign_in'
    end
    it 'お問い合わせ完了画面' do
      visit thank_contacts_path
      is_expected.to eq '/users/sign_in'
    end
  end
end
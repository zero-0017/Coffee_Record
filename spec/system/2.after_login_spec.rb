# frozen_string_literal: true

require 'rails_helper'

describe '会員ログイン後のテスト' do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:post_coffee) { create(:post_coffee, user: user) }
  let!(:other_post_coffee) { create(:post_coffee, user: other_user) }
  let!(:contact) { create(:contact, user: user) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    context 'リンクの内容を確認: ※logoutは『ユーザログアウトのテスト』でテスト済みになります。' do
      subject { current_path }

      it 'マイページを押すと、自分の会員詳細画面に遷移する' do
        user_link = find_all('a')[1].native.inner_text
        user_link = user_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link user_link
        is_expected.to eq '/users/' + user.id.to_s
      end
      it '会員一覧を押すと、会員一覧画面に遷移する' do
        users_link = find_all('a')[2].native.inner_text
        users_link = users_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link users_link
        is_expected.to eq '/users'
      end
      it '新規投稿を押すと、新規投稿画面に遷移する' do
        post_coffee_link = find_all('a')[3].native.inner_text
        post_coffee_link = post_coffee_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link post_coffee_link
        is_expected.to eq '/post_coffees/new'
      end
      it '投稿一覧を押すと、投稿一覧画面に遷移する' do
        post_coffees_link = find_all('a')[4].native.inner_text
        post_coffees_link = post_coffees_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link post_coffees_link
        is_expected.to eq '/post_coffees'
      end
    end
  end

  describe '新規投稿画面のテスト' do
    before do
      visit new_post_coffee_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/post_coffees/new'
      end
      it '「新規投稿」と表示される' do
        expect(page).to have_content '新規投稿'
      end
    end

    context '新規投稿の確認' do
      it '「新規投稿」と表示される' do
        expect(page).to have_content '新規投稿'
      end
      it '画像フォームが表示される' do
        expect(page).to have_field 'post_coffee[image]'
      end
      it '画像フォームに値が入っていない' do
        expect(find_field('post_coffee[image]').text).to be_blank
      end
      it '投稿名フォームが表示される' do
        expect(page).to have_field 'post_coffee[post_name]'
      end
      it '投稿名フォームに値が入っていない' do
        expect(find_field('post_coffee[post_name]').text).to be_blank
      end
      it '珈琲の淹れ方セレクトが表示される' do
        expect(page).to have_select 'post_coffee[coffee_brew_id]'
      end
      it '珈琲の種類セレクトが表示される' do
        expect(page).to have_select 'post_coffee[coffee_id]'
      end
      it '投稿説明フォームが表示される' do
        expect(page).to have_field 'post_coffee[post_explanation]'
      end
      it '投稿説明フォームに値が入っていない' do
        expect(find_field('post_coffee[post_explanation]').text).to be_blank
      end
      it '新規投稿ボタンが表示される' do
        expect(page).to have_button '新規投稿'
      end
    end

    context '投稿成功のテスト' do
      before do
        visit new_post_coffee_path
        fill_in 'post_coffee[post_name]', with: Faker::Lorem.characters(number: 25)
        fill_in 'post_coffee[post_explanation]', with: Faker::Lorem.characters(number: 200)
      end

      context '表示内容の確認' do
        it 'URLが正しい' do
          expect(current_path).to eq '/post_coffees/new'
        end
        it '自分の新しい投稿が正しく保存される' do
          expect { click_button '新規投稿' }.to change(user.post_coffees, :count).by(0)
        end
        it 'リダイレクト先が、保存できた投稿一覧画面になっている' do
          click_button '新規投稿'
          expect(current_path).to eq '/post_coffees'
        end
      end
    end
  end

  describe '投稿一覧画面のテスト' do
    before do
      visit post_coffees_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/post_coffees'
      end
      it '「投稿一覧」と表示される' do
        expect(page).to have_content '投稿一覧'
      end
      it '自分の投稿と他人の投稿の画像のリンク先が正しい' do
        expect(page).to have_link '', href: post_coffee_path(post_coffee)
        expect(page).to have_link '', href: post_coffee_path(other_post_coffee)
      end
    end
  end

  describe '自分の投稿詳細画面のテスト' do
    before do
      visit post_coffee_path(post_coffee)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/post_coffees/' + post_coffee.id.to_s
      end
      it '「投稿詳細」と表示される' do
        expect(page).to have_content '投稿詳細'
      end
      it '会員画像・名前のリンク先が正しい' do
        expect(page).to have_link post_coffee.user.name, href: user_path(post_coffee.user)
      end
      it '投稿の投稿名が表示される' do
        expect(page).to have_content post_coffee.post_name
      end
      it '投稿の珈琲の淹れ方が表示される' do
        expect(page).to have_content post_coffee.coffee_brew.coffee_brew_name
      end
      it '投稿の珈琲の種類が表示される' do
        expect(page).to have_content post_coffee.coffee.coffee_name
      end
      it '投稿の投稿説明が表示される' do
        expect(page).to have_content post_coffee.post_explanation
      end
      it '投稿の編集リンクが表示される' do
        expect(page).to have_link '編集', href: edit_post_coffee_path(post_coffee)
      end
      it '投稿の削除リンクが表示される' do
        expect(page).to have_link '削除', href: post_coffee_path(post_coffee)
      end
    end

    context '編集リンクのテスト' do
      it '編集画面に遷移する' do
        click_link '編集'
        expect(current_path).to eq '/post_coffees/' + post_coffee.id.to_s + '/edit'
      end
    end

    context '削除リンクのテスト' do
      it 'application.html.erbにjavascript_pack_tagを含んでいる' do
        is_exist = 0
        open("app/views/layouts/application.html.erb").each do |line|
          strip_line = line.chomp.gsub(" ", "")
          if strip_line.include?("<%=javascript_pack_tag'application','data-turbolinks-track':'reload'%>")
            is_exist = 1
            break
          end
        end
        expect(is_exist).to eq(1)
      end
      before do
        click_link '削除'
      end
      it '正しく削除される' do
        expect(PostCoffee.where(id: post_coffee.id).count).to eq 0
      end
      it 'リダイレクト先が、投稿一覧画面になっている' do
        expect(current_path).to eq '/post_coffees'
      end
    end
  end

  describe '自分の投稿編集画面のテスト' do
    before do
      visit edit_post_coffee_path(post_coffee)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/post_coffees/' + post_coffee.id.to_s + '/edit'
      end
      it '「投稿編集」と表示される' do
        expect(page).to have_content '投稿編集'
      end
      it '投稿名編集フォームが表示される' do
        expect(page).to have_field 'post_coffee[post_name]', with: post_coffee.post_name
      end
      it '投稿の珈琲の淹れ方が表示される' do
        expect(page).to have_field 'post_coffee[coffee_brew_id]', with: post_coffee.coffee_brew_id
      end
      it '投稿の珈琲の種類が表示される' do
        expect(page).to have_field 'post_coffee[coffee_id]', with: post_coffee.coffee_id
      end
      it '投稿説明編集フォームが表示される' do
        expect(page).to have_field 'post_coffee[post_explanation]', with: post_coffee.post_explanation
      end
      it '変更内容保存ボタンが表示される' do
        expect(page).to have_button '変更内容保存'
      end
    end

    context '編集成功のテスト' do
      before do
        @post_coffee_old_post_name = post_coffee.post_name
        @post_coffee_old_post_explanation = post_coffee.post_explanation
        fill_in 'post_coffee[post_name]', with: Faker::Lorem.characters(number: 20)
        fill_in 'post_coffee[post_explanation]', with: Faker::Lorem.characters(number: 100)
        click_button '変更内容保存'
      end

      it '投稿名が正しく更新される' do
        expect(post_coffee.reload.post_name).not_to eq @post_coffee_old_post_name
      end
      it '投稿説明が正しく更新される' do
        expect(post_coffee.reload.post_explanation).not_to eq @post_coffee_old_post_explanation
      end
      it 'リダイレクト先が、更新した投稿の詳細画面になっている' do
        expect(current_path).to eq '/post_coffees/' + post_coffee.id.to_s
        expect(page).to have_content '投稿詳細'
      end
    end
  end

  describe '会員覧画面のテスト' do
    before do
      visit users_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users'
      end
      it '自分と他人の画像が表示される' do
        expect(all('img').size).to eq(2)
      end
      it '他人の名前がそれぞれ表示される' do
        expect(page).to have_content other_user.name
      end
      it '他人の自己紹介文がそれぞれ表示される' do
        expect(page).to have_content other_user.introduction
      end
    end
  end

  describe '自分のマイページ画面のテスト' do
    before do
      visit user_path(user)
    end

    context '表示の確認' do
      it '自分の名前と紹介文が表示される' do
        expect(page).to have_content user.name
        expect(page).to have_content user.introduction
      end
      it '自分の会員編集画面へのリンクが存在する' do
        expect(page).to have_link '', href: edit_user_path(user)
      end
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
      it '他人の投稿は表示されない' do
        expect(page).not_to have_link '', href: user_path(other_user)
        expect(page).not_to have_content other_post_coffee.post_name
      end
    end
  end

  describe '自分の会員情報編集画面のテスト' do
    before do
      visit edit_user_path(user)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s + '/edit'
      end
      it '画像編集フォームが表示される' do
        expect(page).to have_field 'user[profile_image]'
      end
      it '名前編集フォームに自分の名前が表示される' do
        expect(page).to have_field 'user[name]', with: user.name
      end
      it '自己紹介編集フォームに自分の自己紹介文が表示される' do
        expect(page).to have_field 'user[introduction]', with: user.introduction
      end
      it '変更内容保存ボタンが表示される' do
        expect(page).to have_button '変更内容保存'
      end
    end

    context '更新成功のテスト' do
      before do
        @user_old_name = user.name
        @user_old_intrpduction = user.introduction
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 9)
        fill_in 'user[introduction]', with: Faker::Lorem.characters(number: 19)
        expect(user.profile_image).to be_attached
        click_button '変更内容保存'
        save_page
      end

      it '名前が正しく更新される' do
        expect(user.reload.name).not_to eq @user_old_name
      end
      it '自己紹介文が正しく更新される' do
        expect(user.reload.introduction).not_to eq @user_old_intrpduction
      end
      it 'リダイレクト先が、自分の会員詳細画面になっている' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
    end
  end

  describe 'お問い合わせ一覧画面のテスト' do
    before do
      visit contacts_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/contacts'
      end
      it '「お問い合わせ」と表示される' do
        expect(page).to have_content 'お問い合わせ'
      end
      it 'お問い合わせの件名が表示される' do
        expect(page).to have_link contact.contact_type, href: contact_path(contact)
      end
      it 'お問い合わせの対応状況が表示される' do
        expect(page).to have_content contact.status
      end
    end
  end

  describe '自分の新規お問い合わせ画面のテスト' do
    before do
      visit new_contact_path
      fill_in 'contact[content]', with: Faker::Lorem.characters(number: 25)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/contacts/new'
      end
      it '自分の新しいお問い合わせが正しく保存される' do
        expect { click_button '送信' }.to change(user.contacts, :count).by(1)
      end
      it 'リダイレクト先が、お問い合わせ完了画面になっている' do
        click_button '送信'
        expect(current_path).to eq '/contacts/thank'
      end
    end
  end

  describe '自分のお問い合わせ詳細画面のテスト' do
    before do
      visit contact_path(contact)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/contacts/' + contact.id.to_s
      end
      it '「お問い合わせ詳細」と表示される' do
        expect(page).to have_content 'お問い合わせ詳細'
      end
      it 'お問い合わせの件名が表示される' do
        expect(page).to have_content contact.contact_type
      end
      it 'お問い合わせの内容が表示される' do
        expect(page).to have_content contact.content
      end
      it 'お問い合わせの対応状況が表示される' do
        expect(page).to have_content contact.status
      end
      it 'お問い合わせの削除リンクが表示される' do
        expect(page).to have_link '削除', href: contact_path(contact)
      end
    end

    context '削除リンクのテスト' do
      it 'application.html.erbにjavascript_pack_tagを含んでいる' do
        is_exist = 0
        open("app/views/layouts/application.html.erb").each do |line|
          strip_line = line.chomp.gsub(" ", "")
          if strip_line.include?("<%=javascript_pack_tag'application','data-turbolinks-track':'reload'%>")
            is_exist = 1
            break
          end
        end
        expect(is_exist).to eq(1)
      end
      before do
        click_link '削除'
      end
      it '正しく削除される' do
        expect(Contact.where(id: contact.id).count).to eq 0
      end
      it 'リダイレクト先が、お問い合わせ一覧画面になっている' do
        expect(current_path).to eq '/contacts'
      end
    end
  end
end
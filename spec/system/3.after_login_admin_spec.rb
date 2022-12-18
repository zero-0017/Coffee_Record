# frozen_string_literal: true

require "rails_helper"

describe "管理者ログイン後のテスト" do
  let(:admin) { create(:admin) }
  let!(:coffee_brew) { create(:coffee_brew) }
  let!(:coffee) { create(:coffee) }
  let!(:coffee_bean) { create(:coffee_bean) }
  let!(:user) { create(:user) }
  let!(:post_coffee) { create(:post_coffee, user: user) }
  let!(:contact) { create(:contact, user: user) }
  let!(:coffee_comment) { create(:coffee_comment, post_coffee: post_coffee, user: user) }

  before do
    visit new_admin_session_path
    fill_in "admin[email]", with: admin.email
    fill_in "admin[password]", with: admin.password
    click_button "ログイン"
  end

  describe "ヘッダーのテスト: ログインしている場合" do
    context "リンクの内容を確認" do
      subject { current_path }

      it "お問い合わせ一覧を押すと、自分のお問い合わせ一覧画面に遷移する" do
        contact_link = find_all("a")[1].native.inner_text
        contact_link = contact_link.delete("\n").gsub(/\A\s*/, "").gsub(/\s*\Z/, "")
        click_link contact_link, match: :first
        is_expected.to eq "/admin/contacts"
      end
      it "会員一覧を押すと、会員一覧画面に遷移する" do
        user_link = find_all("a")[2].native.inner_text
        user_link = user_link.delete("\n").gsub(/\A\s*/, "").gsub(/\s*\Z/, "")
        click_link user_link, match: :first
        is_expected.to eq "/admin/users"
      end
      it "投稿一覧を押すと、投稿一覧画面に遷移する" do
        post_coffee_link = find_all("a")[3].native.inner_text
        post_coffee_link = post_coffee_link.delete("\n").gsub(/\A\s*/, "").gsub(/\s*\Z/, "")
        click_link post_coffee_link, match: :first
        is_expected.to eq "/admin/post_coffees"
      end
      it "コメント一覧を押すと、コメント一覧画面に遷移する" do
        coffee_comment_link = find_all("a")[4].native.inner_text
        coffee_comment_link = coffee_comment_link.delete("\n").gsub(/\A\s*/, "").gsub(/\s*\Z/, "")
        click_link coffee_comment_link, match: :first
        is_expected.to eq "/admin/coffee_comments"
      end
    end
  end

  describe "管理者トップ画面のテスト" do
    before do
      visit admin_path
    end

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/admin"
      end
      it "「管理一覧リスト」と表示される" do
        expect(page).to have_content "管理一覧リスト"
      end
      it "珈琲の淹れ方一覧リンクが表示される: 上から1番目である" do
        coffee_brew_link = find_all("a")[6].native.inner_text
        expect(coffee_brew_link).to match(/珈琲の淹れ方一覧/)
      end
      it "珈琲の種類一覧リンクが表示される: 上から2番目である" do
        coffee_link = find_all("a")[7].native.inner_text
        expect(coffee_link).to match(/珈琲の種類一覧/)
      end
      it "珈琲豆の種類一覧リンクが表示される: 上から3番目である" do
        coffee_bean_link = find_all("a")[8].native.inner_text
        expect(coffee_bean_link).to match(/珈琲豆の種類一覧/)
      end
      it "お問い合わせ一覧リンクが表示される: 上から4番目である" do
        coffee_bean_link = find_all("a")[9].native.inner_text
        expect(coffee_bean_link).to match(/お問い合わせ一覧/)
      end
      it "会員一覧リンクが表示される: 上から5番目である" do
        coffee_bean_link = find_all("a")[10].native.inner_text
        expect(coffee_bean_link).to match(/会員一覧/)
      end
      it "投稿一覧リンクが表示される: 上から6番目である" do
        coffee_bean_link = find_all("a")[11].native.inner_text
        expect(coffee_bean_link).to match(/投稿一覧/)
      end
      it "コメント一覧リンクが表示される: 上から7番目である" do
        coffee_bean_link = find_all("a")[12].native.inner_text
        expect(coffee_bean_link).to match(/コメント一覧/)
      end
    end
  end

  describe "珈琲の淹れ方一覧画面のテスト" do
    before do
      visit admin_coffee_brews_path
    end

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/admin/coffee_brews"
      end
      it "「珈琲の淹れ方一覧・追加」と表示される" do
        expect(page).to have_content "珈琲の淹れ方一覧・追加"
      end
      it "珈琲の淹れ方名が表示される" do
        expect(page).to have_content coffee_brew.coffee_brew_name
      end
      it "編集リンクが表示される" do
        expect(page).to have_link "編集", href: edit_admin_coffee_brew_path(coffee_brew)
      end
    end

    context "編集リンクのテスト" do
      it "珈琲の淹れ方名編集画面に遷移する" do
        click_link "編集", match: :first
        expect(current_path).to eq "/admin/coffee_brews/" + coffee_brew.id.to_s + "/edit"
      end
    end
  end

  describe "珈琲の淹れ方名編集画面のテスト" do
    before do
      visit edit_admin_coffee_brew_path(coffee_brew)
    end

    context "表示の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/admin/coffee_brews/" + coffee_brew.id.to_s + "/edit"
      end
      it "「珈琲の淹れ方名編集」と表示される" do
        expect(page).to have_content "珈琲の淹れ方名編集"
      end
      it "珈琲の淹れ方名の編集フォームが表示される" do
        expect(page).to have_field "coffee_brew[coffee_brew_name]", with: coffee_brew.coffee_brew_name
      end
      it "変更内容保存ボタンが表示される" do
        expect(page).to have_button "変更内容保存"
      end
      it "珈琲の淹れ方名の削除リンクが表示される" do
        expect(page).to have_link "削除", href: admin_coffee_brew_path(coffee_brew)
      end
    end

    context "編集成功のテスト" do
      before do
        @coffee_brew_old_coffee_brew = coffee_brew.coffee_brew_name
        fill_in "coffee_brew[coffee_brew_name]", with: Faker::Lorem.characters(number: 8)
        click_button "変更内容保存"
      end

      it "珈琲の淹れ方名が正しく更新される" do
        expect(coffee_brew.reload.coffee_brew_name).not_to eq @coffee_brew_old_coffee_brew
      end
      it "リダイレクト先が、珈琲の淹れ方一覧画面になっている" do
        expect(current_path).to eq "/admin/coffee_brews"
        expect(page).to have_content "珈琲の淹れ方一覧・追加"
      end
    end

    context "削除リンクのテスト" do
      it "application.html.erbにjavascript_pack_tagを含んでいる" do
        is_exist = 0
        open("app/views/layouts/application.html.erb").each do |line|
          strip_line = line.chomp.delete(" ")
          if strip_line.include?("<%=javascript_pack_tag'application','data-turbolinks-track':'reload'%>")
            is_exist = 1
            break
          end
        end
        expect(is_exist).to eq(1)
      end
      before do
        click_link "削除"
      end
      it "正しく削除される" do
        expect(CoffeeBrew.where(id: coffee_brew.id).count).to eq 0
      end
      it "リダイレクト先が、珈琲の淹れ方一覧画面になっている" do
        expect(current_path).to eq "/admin/coffee_brews"
        expect(page).to have_content "珈琲の淹れ方一覧・追加"
      end
    end
  end

  describe "珈琲の種類一覧画面のテスト" do
    before do
      visit admin_coffees_path
    end

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/admin/coffees"
      end
      it "「珈琲の種類一覧・追加」と表示される" do
        expect(page).to have_content "珈琲の種類一覧・追加"
      end
      it "珈琲の種類名が表示される" do
        expect(page).to have_content coffee.coffee_name
      end
      it "編集リンクが表示される" do
        expect(page).to have_link "編集", href: edit_admin_coffee_path(coffee)
      end
    end

    context "編集リンクのテスト" do
      it "珈琲の種類名編集画面に遷移する" do
        click_link "編集", match: :first
        expect(current_path).to eq "/admin/coffees/" + coffee.id.to_s + "/edit"
      end
    end
  end

  describe "珈琲の種類名編集画面のテスト" do
    before do
      visit edit_admin_coffee_path(coffee)
    end

    context "表示の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/admin/coffees/" + coffee.id.to_s + "/edit"
      end
      it "「珈琲の種類名編集」と表示される" do
        expect(page).to have_content "珈琲の種類名編集"
      end
      it "珈琲の種類名の編集フォームが表示される" do
        expect(page).to have_field "coffee[coffee_name]", with: coffee.coffee_name
      end
      it "変更内容保存ボタンが表示される" do
        expect(page).to have_button "変更内容保存"
      end
      it "珈琲の種類名の削除リンクが表示される" do
        expect(page).to have_link "削除", href: admin_coffee_path(coffee)
      end
    end

    context "編集成功のテスト" do
      before do
        @coffee_old_coffee = coffee.coffee_name
        fill_in "coffee[coffee_name]", with: Faker::Lorem.characters(number: 8)
        click_button "変更内容保存"
      end

      it "珈琲の種類名が正しく更新される" do
        expect(coffee.reload.coffee_name).not_to eq @coffee_old_coffee
      end
      it "リダイレクト先が、珈琲の種類一覧画面になっている" do
        expect(current_path).to eq "/admin/coffees"
        expect(page).to have_content "珈琲の種類一覧・追加"
      end
    end

    context "削除リンクのテスト" do
      it "application.html.erbにjavascript_pack_tagを含んでいる" do
        is_exist = 0
        open("app/views/layouts/application.html.erb").each do |line|
          strip_line = line.chomp.delete(" ")
          if strip_line.include?("<%=javascript_pack_tag'application','data-turbolinks-track':'reload'%>")
            is_exist = 1
            break
          end
        end
        expect(is_exist).to eq(1)
      end
      before do
        click_link "削除"
      end
      it "正しく削除される" do
        expect(Coffee.where(id: coffee.id).count).to eq 0
      end
      it "リダイレクト先が、珈琲の種類一覧画面になっている" do
        expect(current_path).to eq "/admin/coffees"
        expect(page).to have_content "珈琲の種類一覧・追加"
      end
    end
  end

  describe "珈琲豆の種類一覧画面のテスト" do
    before do
      visit admin_coffee_beans_path
    end

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/admin/coffee_beans"
      end
      it "「珈琲豆の種類一覧・追加」と表示される" do
        expect(page).to have_content "珈琲豆の種類一覧・追加"
      end
      it "珈琲豆の種類名が表示される" do
        expect(page).to have_content coffee_bean.coffee_bean_name
      end
      it "編集リンクが表示される" do
        expect(page).to have_link "編集", href: edit_admin_coffee_bean_path(coffee_bean)
      end
    end

    context "編集リンクのテスト" do
      it "珈琲豆の種類名編集画面に遷移する" do
        click_link "編集", match: :first
        expect(current_path).to eq "/admin/coffee_beans/" + coffee_bean.id.to_s + "/edit"
      end
    end
  end

  describe "珈琲豆の種類名編集画面のテスト" do
    before do
      visit edit_admin_coffee_bean_path(coffee_bean)
    end

    context "表示の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/admin/coffee_beans/" + coffee_bean.id.to_s + "/edit"
      end
      it "「珈琲豆の種類名編集」と表示される" do
        expect(page).to have_content "珈琲豆の種類名編集"
      end
      it "珈琲豆の種類名の編集フォームが表示される" do
        expect(page).to have_field "coffee_bean[coffee_bean_name]", with: coffee_bean.coffee_bean_name
      end
      it "変更内容保存ボタンが表示される" do
        expect(page).to have_button "変更内容保存"
      end
      it "珈琲豆の種類名の削除リンクが表示される" do
        expect(page).to have_link "削除", href: admin_coffee_bean_path(coffee_bean)
      end
    end

    context "編集成功のテスト" do
      before do
        @coffee_bean_old_coffee_bean = coffee_bean.coffee_bean_name
        fill_in "coffee_bean[coffee_bean_name]", with: Faker::Lorem.characters(number: 8)
        click_button "変更内容保存"
      end

      it "珈琲豆の種類名が正しく更新される" do
        expect(coffee_bean.reload.coffee_bean_name).not_to eq @coffee_bean_old_coffee_bean
      end
      it "リダイレクト先が、珈琲豆の種類一覧画面になっている" do
        expect(current_path).to eq "/admin/coffee_beans"
        expect(page).to have_content "珈琲豆の種類一覧・追加"
      end
    end

    context "削除リンクのテスト" do
      it "application.html.erbにjavascript_pack_tagを含んでいる" do
        is_exist = 0
        open("app/views/layouts/application.html.erb").each do |line|
          strip_line = line.chomp.delete(" ")
          if strip_line.include?("<%=javascript_pack_tag'application','data-turbolinks-track':'reload'%>")
            is_exist = 1
            break
          end
        end
        expect(is_exist).to eq(1)
      end
      before do
        click_link "削除"
      end
      it "正しく削除される" do
        expect(CoffeeBean.where(id: coffee_bean.id).count).to eq 0
      end
      it "リダイレクト先が、珈琲豆の種類一覧画面になっている" do
        expect(current_path).to eq "/admin/coffee_beans"
        expect(page).to have_content "珈琲豆の種類一覧・追加"
      end
    end
  end

  describe "投稿一覧画面のテスト" do
    before do
      visit admin_post_coffees_path
    end

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/admin/post_coffees"
      end
      it "「投稿一覧」と表示される" do
        expect(page).to have_content "投稿一覧"
      end
      it "会員名のリンク先が正しい" do
        expect(page).to have_link post_coffee.user.name, href: admin_user_path(post_coffee.user)
      end
    end
  end

  describe "投稿詳細画面のテスト" do
    before do
      visit admin_post_coffee_path(post_coffee)
    end

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/admin/post_coffees/" + post_coffee.id.to_s
      end
      it "「投稿詳細」と表示される" do
        expect(page).to have_content "投稿詳細"
      end
      it "会員画像・名前のリンク先が正しい" do
        expect(page).to have_link post_coffee.user.name, href: admin_user_path(post_coffee.user)
      end
      it "投稿の投稿名が表示される" do
        expect(page).to have_content post_coffee.post_name
      end
      it "投稿の珈琲の淹れ方が表示される" do
        expect(page).to have_content post_coffee.coffee_brew.coffee_brew_name
      end
      it "投稿の珈琲の種類が表示される" do
        expect(page).to have_content post_coffee.coffee.coffee_name
      end
      it "投稿の投稿説明が表示される" do
        expect(page).to have_content post_coffee.post_explanation
      end
      it "投稿の削除リンクが表示される" do
        expect(page).to have_link "削除", href: admin_post_coffee_path(post_coffee)
      end
    end

    context "削除リンクのテスト" do
      it "application.html.erbにjavascript_pack_tagを含んでいる" do
        is_exist = 0
        open("app/views/layouts/application.html.erb").each do |line|
          strip_line = line.chomp.delete(" ")
          if strip_line.include?("<%=javascript_pack_tag'application','data-turbolinks-track':'reload'%>")
            is_exist = 1
            break
          end
        end
        expect(is_exist).to eq(1)
      end
      before do
        click_link "削除", match: :first
      end
      it "正しく削除される" do
        expect(PostCoffee.where(id: post_coffee.id).count).to eq 0
      end
      it "リダイレクト先が、投稿一覧画面になっている" do
        expect(current_path).to eq "/admin/post_coffees"
      end
    end
  end

  describe "会員一覧画面のテスト" do
    before do
      visit admin_users_path
    end

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/admin/users"
      end
      it "「会員一覧」と表示される" do
        expect(page).to have_content "会員一覧"
      end
      it "会員IDが表示される" do
        expect(page).to have_content user.id
      end
      it "会員名が表示される" do
        expect(page).to have_content user.name
      end
      it "会員のメールアドレスがそれぞれ表示される" do
        expect(page).to have_content user.email
      end
    end
  end

  describe "会員詳細画面のテスト" do
    before do
      visit admin_user_path(user)
    end

    context "表示の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/admin/users/" + user.id.to_s
      end
      it "「(会員名)のマイページ」と表示される" do
        expect(page).to have_content user.name + "のマイページ"
      end
      it "会員の名前と紹介文とメールアドレスが表示される" do
        expect(page).to have_content user.name
        expect(page).to have_content user.introduction
        expect(page).to have_content user.email
      end
    end
  end

  describe "お問い合わせ一覧画面のテスト" do
    before do
      visit admin_contacts_path
    end

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/admin/contacts"
      end
      it "「お問い合わせ一覧」と表示される" do
        expect(page).to have_content "お問い合わせ一覧"
      end
      it "お問い合わせの件名が表示される" do
        expect(page).to have_link contact.contact_type, href: admin_contact_path(contact)
      end
      it "お問い合わせの対応状況が表示される" do
        expect(page).to have_content contact.status
      end
    end
  end

  describe "自分のお問い合わせ詳細画面のテスト" do
    before do
      visit admin_contact_path(contact)
    end

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/admin/contacts/" + contact.id.to_s
      end
      it "「お問い合わせ詳細」と表示される" do
        expect(page).to have_content "お問い合わせ詳細"
      end
      it "お問い合わせの件名が表示される" do
        expect(page).to have_content contact.contact_type
      end
      it "お問い合わせの内容が表示される" do
        expect(page).to have_content contact.content
      end
      it "お問い合わせの対応状況が表示される" do
        expect(page).to have_content contact.status
      end
    end
  end

  describe "コメント一覧画面のテスト" do
    before do
      visit admin_coffee_comments_path
    end

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/admin/coffee_comments"
      end
      it "「コメント一覧」と表示される" do
        expect(page).to have_content "コメント一覧"
      end
      it "コメントのコメント内容が表示される" do
        expect(page).to have_content coffee_comment.comment
      end
      it "コメントの削除リンクが表示される" do
        expect(page).to have_link "削除", href: admin_post_coffee_coffee_comment_path(coffee_comment.post_coffee, coffee_comment)
      end
    end

    context "削除リンクのテスト" do
      it "application.html.erbにjavascript_pack_tagを含んでいる" do
        is_exist = 0
        open("app/views/layouts/application.html.erb").each do |line|
          strip_line = line.chomp.delete(" ")
          if strip_line.include?("<%=javascript_pack_tag'application','data-turbolinks-track':'reload'%>")
            is_exist = 1
            break
          end
        end
        expect(is_exist).to eq(1)
      end
      before do
        click_link "削除"
      end
      it "正しく削除される" do
        expect(PostCoffee.where(id: post_coffee.id).count).to eq 1
      end
      it "リダイレクト先が、コメント一覧画面になっている" do
        expect(current_path).to eq "/admin/coffee_comments"
      end
    end
  end
end

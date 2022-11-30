# frozen_string_literal: true

require "rails_helper"

RSpec.describe "PostCoffeeモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    subject { post_coffee.valid? }

    let(:user) { create(:user) }
    let(:coffee_brew) { create(:coffee_brew) }
    let(:coffee) { create(:coffee) }
    let(:coffee_bean_ids) { create(:coffee_bean_ids) }
    let!(:post_coffee) { build(:post_coffee, user_id: user.id) }

    context "post_nameカラム" do
      it "空欄でないこと" do
        post_coffee.post_name = ""
        is_expected.to eq false
      end
      it "25文字以下であること: 25文字は○" do
        post_coffee.post_name = Faker::Lorem.characters(number: 25)
        is_expected.to eq true
      end
      it "25文字以下であること: 26文字は×" do
        post_coffee.post_name = Faker::Lorem.characters(number: 26)
        is_expected.to eq false
      end
    end

    context "post_explanationカラム" do
      it "空欄でないこと" do
        post_coffee.post_explanation = ""
        is_expected.to eq false
      end
      it "200文字以下であること: 200文字は○" do
        post_coffee.post_explanation = Faker::Lorem.characters(number: 200)
        is_expected.to eq true
      end
      it "200文字以下であること: 201文字は×" do
        post_coffee.post_explanation = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end

    context "coffee_bean_idsカラム" do
      it "空欄でないこと" do
        post_coffee.coffee_bean_ids = ""
        is_expected.to eq false
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "Userモデルとの関係" do
      it "N:1となっている" do
        expect(PostCoffee.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context "CoffeeBrewモデルとの関係" do
      it "N:1となっている" do
        expect(PostCoffee.reflect_on_association(:coffee_brew).macro).to eq :belongs_to
      end
    end
    context "Coffeeモデルとの関係" do
      it "N:1となっている" do
        expect(PostCoffee.reflect_on_association(:coffee).macro).to eq :belongs_to
      end
    end

    context "CoffeeCommentモデルとの関係" do
      it "1:Nとなっている" do
        expect(PostCoffee.reflect_on_association(:coffee_comments).macro).to eq :has_many
      end
    end
    context "Favoriteモデルとの関係" do
      it "1:Nとなっている" do
        expect(PostCoffee.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end
    context "SetCoffeeBeanモデルとの関係" do
      it "1:Nとなっている" do
        expect(PostCoffee.reflect_on_association(:set_coffee_beans).macro).to eq :has_many
      end
    end
    context "CoffeeBeanモデルとの関係" do
      it "1:Nとなっている" do
        expect(PostCoffee.reflect_on_association(:coffee_beans).macro).to eq :has_many
      end
    end
    context "Notificationモデルとの関係" do
      it "1:Nとなっている" do
        expect(PostCoffee.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end
  end
end

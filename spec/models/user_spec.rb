# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Userモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    subject { user.valid? }

    let!(:other_user) { create(:user) }
    let(:user) { build(:user) }

    context "nameカラム" do
      it "空欄でないこと" do
        user.name = ""
        is_expected.to eq false
      end
      it "10文字以下であること: 10文字は〇" do
        user.name = Faker::Lorem.characters(number: 10)
        is_expected.to eq true
      end
      it "10文字以下であること: 11文字は×" do
        user.name = Faker::Lorem.characters(number: 11)
        is_expected.to eq false
      end
    end

    context "introductionカラム" do
      it "100文字以下であること: 100文字は〇" do
        user.introduction = Faker::Lorem.characters(number: 100)
        is_expected.to eq true
      end
      it "100文字以下であること: 101文字は×" do
        user.introduction = Faker::Lorem.characters(number: 101)
        is_expected.to eq false
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "PostCoffeeモデルとの関係" do
      it "1:Nとなっている" do
        expect(User.reflect_on_association(:post_coffees).macro).to eq :has_many
      end
    end
    context "CoffeeCommentモデルとの関係" do
      it "1:Nとなっている" do
        expect(User.reflect_on_association(:coffee_comments).macro).to eq :has_many
      end
    end
    context "Favoriteモデルとの関係" do
      it "1:Nとなっている" do
        expect(User.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end
    context "Contactモデルとの関係" do
      it "1:Nとなっている" do
        expect(User.reflect_on_association(:contacts).macro).to eq :has_many
      end
    end
    context "ActiveNotificationモデルとの関係(通知を送る)" do
      it "1:Nとなっている" do
        expect(User.reflect_on_association(:active_notifications).macro).to eq :has_many
      end
    end
    context "PassiveNotificationモデルとの関係(通知を受け取る)" do
      it "1:Nとなっている" do
        expect(User.reflect_on_association(:passive_notifications).macro).to eq :has_many
      end
    end
  end
end

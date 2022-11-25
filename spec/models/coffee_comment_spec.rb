# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "CoffeeCommentモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    subject {coffee_comment.valid? }

    let(:user) { create(:user) }
    let(:post_coffee) { create(:post_coffee, user_id: user.id) }
    let(:coffee_comment) { build(:coffee_comment, post_coffee_id: post_coffee.id, user_id: user.id) }

    context "commentカラム" do
      it '空白でないこと' do
        coffee_comment.comment = ""
        is_expected.to eq false
      end
      it "100文字以内であること:100文字は◯" do
        coffee_comment.comment = Faker::Lorem.characters(number: 100)
        is_expected.to eq true
      end
      it "100文字以内であること:101文字は×" do
        coffee_comment.comment = Faker::Lorem.characters(number: 101)
        is_expected.to eq false
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "Userモデルとの関係" do
      it "N:1となっている" do
        expect(CoffeeComment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context "PostCoffeeモデルとの関係" do
      it "N:1となっている" do
        expect(CoffeeComment.reflect_on_association(:post_coffee).macro).to eq :belongs_to
      end
    end
  end
end
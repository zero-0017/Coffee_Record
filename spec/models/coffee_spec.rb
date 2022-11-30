# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Coffeeモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    subject { coffee.valid? }

    let(:user) { create(:user) }
    let(:post_coffee) { create(:post_coffee) }
    let!(:coffee) { build(:coffee) }

    context "coffee_nameカラム" do
      it "空欄でないこと" do
        coffee.coffee_name = ""
        is_expected.to eq false
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "PostCoffeeモデルとの関係" do
      it "1:Nとなっている" do
        expect(Coffee.reflect_on_association(:post_coffees).macro).to eq :has_many
      end
    end
  end
end

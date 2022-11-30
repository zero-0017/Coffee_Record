# frozen_string_literal: true

require "rails_helper"

RSpec.describe "CoffeeBrewモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    subject { coffee_brew.valid? }

    let(:user) { create(:user) }
    let(:post_coffee) { create(:post_coffee) }
    let!(:coffee_brew) { build(:coffee_brew) }

    context "coffee_brew_nameカラム" do
      it "空欄でないこと" do
        coffee_brew.coffee_brew_name = ""
        is_expected.to eq false
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "PostCoffeeモデルとの関係" do
      it "1:Nとなっている" do
        expect(CoffeeBrew.reflect_on_association(:post_coffees).macro).to eq :has_many
      end
    end
  end
end

# frozen_string_literal: true

require "rails_helper"

RSpec.describe "SetCoffeeBeanモデルのテスト", type: :model do
  describe "アソシエーションのテスト" do
    context "PostCoffeeモデルとの関係" do
      it "N:1となっている" do
        expect(SetCoffeeBean.reflect_on_association(:post_coffee).macro).to eq :belongs_to
      end
    end
    context "CoffeeBeanモデルとの関係" do
      it "N:1となっている" do
        expect(SetCoffeeBean.reflect_on_association(:coffee_bean).macro).to eq :belongs_to
      end
    end
  end
end

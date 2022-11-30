# frozen_string_literal: true

require "rails_helper"

RSpec.describe "CoffeeBeanモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    subject { coffee_bean.valid? }

    let(:user) { create(:user) }
    let(:post_coffee) { create(:post_coffee) }
    let!(:coffee_bean) { build(:coffee_bean) }

    context "coffee_bean_nameカラム" do
      it "空欄でないこと" do
        coffee_bean.coffee_bean_name = ""
        is_expected.to eq false
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "PostCoffeeモデルとの関係" do
      it "1:Nとなっている" do
        expect(CoffeeBean.reflect_on_association(:post_coffees).macro).to eq :has_many
      end
    end
    context "SetCoffeeBeanモデルとの関係" do
      it "1:Nとなっている" do
        expect(CoffeeBean.reflect_on_association(:set_coffee_beans).macro).to eq :has_many
      end
    end
  end
end

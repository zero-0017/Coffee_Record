# frozen_string_literal: true

require "rails_helper"

RSpec.describe Notification, type: :model do
  describe "アソシエーションのテスト" do
    context "PostCoffeeモデルとの関係" do
      it "N:1となっている" do
        expect(Notification.reflect_on_association(:post_coffee).macro).to eq :belongs_to
      end
    end
    context "Userモデルとの関係(通知を送る)" do
      it "N:1となっている" do
        expect(Notification.reflect_on_association(:visiter).macro).to eq :belongs_to
      end
    end
    context "Userモデルとの関係(通知を受け取る)" do
      it "N:1となっている" do
        expect(Notification.reflect_on_association(:visited).macro).to eq :belongs_to
      end
    end
  end
end

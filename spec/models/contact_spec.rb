# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Contactモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    subject {contact.valid? }

    let(:user) {create(:user) }
    let!(:contact) { build(:contact, user_id: user.id) }

    context "contentカラム" do
      it "空欄でないこと" do
        contact.content = ""
        is_expected.to eq false
      end
      it "200文字以内であること:200文字は○" do
        contact.content = Faker::Lorem.characters(number: 200)
        is_expected.to eq true
      end
      it "200文字以内であること:201文字は×" do
        contact.content = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "Userモデルとの関係" do
      it "N:1となっている" do
        expect(Contact.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
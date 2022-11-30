# frozen_string_literal: true

require "rails_helper"

RSpec.describe Relationship, type: :model do
  subject { relationship.valid? }

  let!(:relationship) { create(:relationship) }

  it "関係性が有効であること" do
    expect(relationship).to be_valid
  end

  it "follower_idがnilの場合、関係性が無効であること" do
    relationship.follower_id = nil
    expect(relationship).not_to be_valid
  end

  it "followed_idがnilの場合、関係性が無効であること" do
    relationship.followed_id = nil
    expect(relationship).not_to be_valid
  end

  describe "アソシエーションのテスト" do
    context "Userモデルとの関係(フォローした会員)" do
      it "N:1となっている" do
        expect(Relationship.reflect_on_association(:follower).macro).to eq :belongs_to
      end
    end
    context "Userモデルとの関係(フォローされた会員)" do
      it "N:1となっている" do
        expect(Relationship.reflect_on_association(:followed).macro).to eq :belongs_to
      end
    end
  end
end

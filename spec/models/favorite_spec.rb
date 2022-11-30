# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Favoriteモデルのテスト", type: :model do
  let(:user) { create(:user) }
  let(:post_coffee) { create(:post_coffee, user_id: user.id) }
  let(:favorite) { user.favorites.create(post_coffee_id: post_coffee.id) }
  let(:destroy_favorite) { user.favorites.find_by(post_coffee_id: post_coffee.id).destroy }

  it "投稿にお気に入り可能" do
    expect { favorite }.to change { Favorite.count }.by(1)
    expect(user.favorites.count).to eq 1
  end

  it "お気に入り済みであればお気に入り解除可能" do
    expect { favorite }.to change { Favorite.count }.by(1)
    expect { destroy_favorite }.to change { Favorite.count }.by(-1)
    expect(user.favorites.count).to eq 0
  end

  describe "アソシエーションのテスト" do
    context "Userモデルとの関係" do
      it "N:1となっている" do
        expect(Favorite.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context "PostCoffeeモデルとの関係" do
      it "N:1となっている" do
        expect(Favorite.reflect_on_association(:post_coffee).macro).to eq :belongs_to
      end
    end
  end
end

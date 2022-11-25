# frozen_string_literal: true

class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_favorite

  def create
    favorite = current_user.favorites.new(post_coffee_id: @post_coffee.id)
    favorite.save
    @post_coffee.create_notification_favorite(current_user)
  end

  def destroy
    favorite = current_user.favorites.find_by(post_coffee_id: @post_coffee.id)
    favorite.destroy
  end

  private
    def set_favorite
      @post_coffee = PostCoffee.find(params[:post_coffee_id])
    end
end

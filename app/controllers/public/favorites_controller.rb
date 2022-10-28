class Public::FavoritesController < ApplicationController

  def create
    @post_coffee = PostCoffee.find(params[:post_coffee_id])
    favorite = current_user.favorites.new(post_coffee_id: @post_coffee.id)
    favorite.save
    @post_coffee.create_notification_favorite(current_user)
  end

  def destroy
    @post_coffee = PostCoffee.find(params[:post_coffee_id])
    favorite = current_user.favorites.find_by(post_coffee_id: @post_coffee.id)
    favorite.destroy
  end
end

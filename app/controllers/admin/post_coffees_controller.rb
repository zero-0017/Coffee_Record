# frozen_string_literal: true

class Admin::PostCoffeesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @post_coffees = PostCoffee.published.page(params[:page]).per(3)
  end

  def show
    @post_coffee = PostCoffee.find(params[:id])
  end

  def destroy
    @post_coffee = PostCoffee.find(params[:id])
    @post_coffee.destroy
    redirect_to admin_post_coffees_path, alert: "投稿を削除しました"
  end
end

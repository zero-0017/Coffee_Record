# frozen_string_literal: true

class Admin::PostCoffeesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_post_coffee, except: [:index]

  def index
    @post_coffees = PostCoffee.published.page(params[:page]).per(3)
  end

  def show
  end

  def destroy
    @post_coffee.destroy
    redirect_to admin_post_coffees_path, notice: "投稿を削除しました"
  end

  private
    def set_post_coffee
      @post_coffee = PostCoffee.find(params[:id])
    end
end

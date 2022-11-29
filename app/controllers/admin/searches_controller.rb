# frozen_string_literal: true

class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search
    @word = params[:word]
    @range = params[:range]
    if @range == "User"
      @users = User.where("name LIKE ?", "%#{@word}%").page(params[:page]).per(3)
    elsif @range == "PostCoffee"
      @post_coffees = PostCoffee.where("post_name LIKE ?", "%#{@word}%").published.page(params[:page]).per(3)
    else
      @coffee_comments = CoffeeComment.where("comment LIKE ?", "%#{@word}%").page(params[:page]).per(2)
    end
  end
end

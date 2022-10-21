class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search
    @range = params[:range]
    if @range == "User"
      @users = User.looks(params[:search], params[:word]).page(params[:page]).per(4)
    elsif @range == "PostCoffee"
      @post_coffees = PostCoffee.published.looks(params[:search], params[:word]).page(params[:page]).per(4)
    else
      @coffee_comments = CoffeeComment.looks(params[:search], params[:word]).page(params[:page]).per(4)
    end
  end
end

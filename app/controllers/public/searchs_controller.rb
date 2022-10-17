class Public::SearchsController < ApplicationController
before_action :authenticate_user!

  def search
    @post_coffees = PostCoffee.published.looks(params[:search], params[:word]).page(params[:page])
    @tags = Tag.all
    @categorys = Category.all
    @genres = Genre.all
  end
end

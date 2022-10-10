class Public::SearchsController < ApplicationController
  def search
    @post_coffees = PostCoffee.published.looks(params[:search], params[:word]).page(params[:page])
    @tags = Tag.all
    @categorys = Category.all
    @genres_list = Genre.all
  end
end

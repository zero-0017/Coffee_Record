class Public::SearchesController < ApplicationController
before_action :authenticate_user!

  def search
   @keyword = params[:keyword]
   @post_coffees = PostCoffee.where("coffee_name LIKE ?", "%#{@keyword}%").published.page(params[:page])
    @tags = Tag.all
    @categorys = Category.all
    @genres = Genre.all
  end
end
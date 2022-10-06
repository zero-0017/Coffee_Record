class Public::CategorysController < ApplicationController
  def show
    @categorys = Category.all
    @tags = Tag.all
    @category = Category.find(params[:id])
    @category_post_coffees = PostCoffee.where(category_id: @category.id)
  end
end

class Public::TagsController < ApplicationController
  def show
    @tags = Tag.all
    @categorys = Category.all
    @genres_list = Genre.all
    @tag = Tag.find(params[:id])
    @tag_post_coffees = PostCoffee.where(tag_id: @tag.id)
  end
end
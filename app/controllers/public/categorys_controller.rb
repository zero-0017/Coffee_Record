# frozen_string_literal: true

class Public::CategorysController < ApplicationController
  before_action :authenticate_user!

  def show
    @categorys = Category.all
    @tags = Tag.all
    @genres = Genre.all
    @category = Category.find(params[:id])
    @post_coffees = PostCoffee.published.where(category_id: @category.id).page(params[:page])
  end
end

# frozen_string_literal: true

class Public::TagsController < ApplicationController
  before_action :authenticate_user!

  def show
    @tags = Tag.all
    @categorys = Category.all
    @genres = Genre.all
    @tag = Tag.find(params[:id])
    @post_coffees = PostCoffee.published.where(tag_id: @tag.id).page(params[:page])
  end
end

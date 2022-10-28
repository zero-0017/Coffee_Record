class Public::HomesController < ApplicationController
  before_action :authenticate_user!, only: [:about]

  def top
  end

  def about
    @tags = Tag.all
    @categorys = Category.all
    @genres = Genre.all
  end
end

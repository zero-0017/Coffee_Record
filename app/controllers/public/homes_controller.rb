class Public::HomesController < ApplicationController
  def top
  end

  def about
    @tags = Tag.all
    @categorys = Category.all
    @genres_list = Genre.all
  end
end

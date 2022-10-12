class Public::HomesController < ApplicationController
  def top
  end

  def about
    @tags = Tag.all
    @categorys = Category.all
    @genres = Genre.all
  end
end

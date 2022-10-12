class Public::GenresController < ApplicationController
  def show
    @categorys = Category.all
    @tags = Tag.all
    @genres = Genre.all
    @genre = Genre.find(params[:id])
    @post_coffees = @genre.post_coffees.published.page(params[:page])
  end
end

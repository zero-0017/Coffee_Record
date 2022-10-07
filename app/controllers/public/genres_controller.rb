class Public::GenresController < ApplicationController
  def show
    @categorys = Category.all
    @tags = Tag.all
    @genres_list = Genre.all
    @genre = Genre.find(params[:id])
    @genres = @genre.post_coffees.all
  end
end

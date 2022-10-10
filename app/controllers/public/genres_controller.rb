class Public::GenresController < ApplicationController
  def show
    @categorys = Category.all
    @tags = Tag.all
    @genres_list = Genre.all
    @genre = Genre.find(params[:id])
    @genre_post_coffees = @genre.post_coffees.published.page(params[:page])
  end
end

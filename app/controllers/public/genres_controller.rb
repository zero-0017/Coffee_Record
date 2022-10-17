class Public::GenresController < ApplicationController
before_action :authenticate_user!

  def show
    @categorys = Category.all
    @tags = Tag.all
    @genres = Genre.all
    @genre = Genre.find(params[:id])
    @post_coffees = @genre.post_coffees.published.page(params[:page])
  end
end

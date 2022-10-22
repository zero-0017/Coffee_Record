class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

  def index
    @genre = Genre.new
    @genres = Genre.page(params[:page]).per(7)
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path, notice: "珈琲豆の種類を作成しました"
    else
      @genres = Genre.page(params[:page]).per(7)
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
      redirect_to admin_genres_path, alert: "珈琲豆の種類を削除しました"
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path, notice: "珈琲豆の種類の変更内容を保存しました"
    else
      render :edit
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:genre_name)
  end
end

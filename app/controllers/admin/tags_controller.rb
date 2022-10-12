class Admin::TagsController < ApplicationController
  def index
    @tag = Tag.new
    @tags = Tag.page(params[:page]).per(9)
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to admin_tags_path, notice: "珈琲の淹れ方名を作成しました"
    else
      @tags = Tag.page(params[:page]).per(9)
      render :index
    end
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
      redirect_to admin_tags_path, notice: "珈琲の淹れ方名を削除しました"
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      redirect_to admin_tags_path, notice: "珈琲の淹れ方名の変更内容を保存しました"
    else
      render :edit
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:tag_name)
  end
end

# frozen_string_literal: true

class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_tag, except: [:index, :create]

  def index
    @tag = Tag.new
    @tags = Tag.page(params[:page]).per(6)
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to admin_tags_path, notice: "珈琲の淹れ方を作成しました"
    else
      @tags = Tag.page(params[:page]).per(6)
      render :index
    end
  end

  def edit
  end

  def destroy
    @tag.destroy
    redirect_to admin_tags_path, alert: "珈琲の淹れ方を削除しました"
  end

  def update
    if @tag.update(tag_params)
      redirect_to admin_tags_path, notice: "珈琲の淹れ方の変更内容を保存しました"
    else
      render :edit
    end
  end

  private
    def tag_params
      params.require(:tag).permit(:tag_name)
    end

    def set_tag
      @tag = Tag.find(params[:id])
    end
end

# frozen_string_literal: true

class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, except: [:index]

  def index
    @users = User.page(params[:page]).per(3)
    @users = User.where.not(name: "ゲストユーザー").page(params[:page]).per(3)
  end

  def show
  end

  def update
    @user.update(user_params)
    redirect_to admin_users_path, notice: "会員情報の変更内容を保存しました"
  end

  private
    def user_params
      params.require(:user).permit(:name, :profile_image, :is_deleted)
    end

    def set_user
      @user = User.find(params[:id])
    end
end

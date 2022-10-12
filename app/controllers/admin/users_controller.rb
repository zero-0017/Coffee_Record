class Admin::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admin_user_path(@user.id), notice: "会員情報の変更内容を保存しました"
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :is_deleted)
  end
end
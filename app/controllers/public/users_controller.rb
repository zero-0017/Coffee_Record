class Public::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @post_coffees = @user.post_coffees
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdrawal
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用をお待ちしております"
    redirect_to root_path
  end

  def favorites
    @user = User.find(params[:id])
    favorites= Favorite.where(user_id: @user.id).pluck(:post_coffee_id)
    @favorite_post_coffees = PostCoffee.find(favorites)
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :is_deleted)
  end
end
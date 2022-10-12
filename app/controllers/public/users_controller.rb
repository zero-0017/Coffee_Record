class Public::UsersController < ApplicationController
before_action :ensure_guest_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    @post_coffees = @user.post_coffees.published
    @tags = Tag.all
    @categorys = Category.all
    @genres_list = Genre.all
  end

  def edit
    @user = User.find(params[:id])
    @tags = Tag.all
    @categorys = Category.all
    @genres_list = Genre.all
    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    @tags = Tag.all
    @categorys = Category.all
    @genres_list = Genre.all
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "会員情報の変更内容を保存しました"
    else
      render :edit
    end
  end

  def unsubscribe
    @genres_list = Genre.all
    @tags = Tag.all
    @categorys = Category.all
  end

  def withdrawal
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path, notice: "ありがとうございました。またのご利用をお待ちしております"
  end

  def favorites
    @user = User.find(params[:id])
    favorites= Favorite.where(user_id: @user.id).pluck(:post_coffee_id)
    @favorite_post_coffees = PostCoffee.find(favorites)
    @favorite_post_coffees = Kaminari.paginate_array(@favorite_post_coffees).page(params[:page])
    @tags = Tag.all
    @categorys = Category.all
    @genres_list = Genre.all
  end

  def post_list
    @user = User.find(params[:id])
    @post_coffees = @user.post_coffees.published.page(params[:page])
    @genres_list = Genre.all
    @tags = Tag.all
    @categorys = Category.all
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :is_deleted)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user), notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
end
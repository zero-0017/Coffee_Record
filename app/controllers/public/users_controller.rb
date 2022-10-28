class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]
  before_action :sidebar_list, except: [:create, :withdrawal]
  before_action :set_user, except: [:index, :unsubscribe, :withdrawal]

  def index
    @users = User.page(params[:page]).per(4)
    @users = User.where.not(id: current_user.id).page(params[:page]).per(4)
  end

  def show
    @post_coffees = @user.post_coffees.published
  end

  def edit
    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "会員情報の変更内容を保存しました"
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
    redirect_to root_path, notice: "ありがとうございました。またのご利用をお待ちしております。"
  end

  def favorites
    favorites= Favorite.where(user_id: @user.id).pluck(:post_coffee_id)
    @post_coffees = PostCoffee.find(favorites)
    @post_coffees = Kaminari.paginate_array(@post_coffees).page(params[:page])
  end

  def post_list
    @post_coffees = @user.post_coffees.published.page(params[:page])
  end

  def followings
    @users = @user.followings.page(params[:page]).per(4)
  end

  def followers
    @users = @user.followers.page(params[:page]).per(4)
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :is_deleted, :email)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "ゲストユーザー"
      redirect_to user_path(current_user), notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def sidebar_list
    @tags = Tag.all
    @categorys = Category.all
    @genres = Genre.all
  end
end
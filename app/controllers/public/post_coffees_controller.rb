class Public::PostCoffeesController < ApplicationController
  before_action :authenticate_user!
  before_action :sidebar_list, except: [:destroy]
  before_action :set_post_coffee, except: [:new, :create, :index, :confirm]

  def new
    @post_coffee = PostCoffee.new
  end

  def create
    @post_coffee = PostCoffee.new(post_coffee_params)
    @post_coffee.user_id = current_user.id
    if @post_coffee.save
      redirect_to post_coffees_path, notice: "投稿しました"
    else
      render :new
    end
  end

  def index
    if params[:latest]
      @post_coffees = PostCoffee.latest.published.page(params[:page])
    elsif params[:old]
      @post_coffees = PostCoffee.old.published.page(params[:page])
    else
      @post_coffees = PostCoffee.published.page(params[:page])
    end
  end

  def show
    @coffee_comment = CoffeeComment.new
  end

  def edit
  end

  def confirm
    @post_coffees = current_user.post_coffees.draft.page(params[:page])
  end

  def update
    if @post_coffee.update(post_coffee_params)
      redirect_to post_coffee_path(@post_coffee), notice: "投稿の変更内容を保存しました"
    else
      render :edit
    end
  end

  def destroy
    @post_coffee.destroy
    redirect_to post_coffees_path, alert: "投稿を削除しました"
  end

  private

  def post_coffee_params
    params.require(:post_coffee).permit(:coffee_name, :coffee_explanation, :image, :status, :tag_id, :category_id, { genre_ids: [] })
  end

  def sidebar_list
    @tags = Tag.all
    @categorys = Category.all
    @genres = Genre.all
  end

  def set_post_coffee
    @post_coffee = PostCoffee.find(params[:id])
  end
end

class Public::PostCoffeesController < ApplicationController

  def new
    @post_coffee = PostCoffee.new
    @tags = Tag.all
    @categorys = Category.all
  end

  def create
    @post_coffee = PostCoffee.new(post_coffee_params)
    @post_coffee.user_id = current_user.id
    @tags = Tag.all
    @categorys = Category.all
    if @post_coffee.save
      redirect_to post_coffees_path
    else
      render :new
    end
  end

  def index
    @post_coffees = PostCoffee.all
    @tags = Tag.all
    @categorys = Category.all
  end

  def show
    @post_coffee = PostCoffee.find(params[:id])
    @coffee_comment = CoffeeComment.new
    @tags = Tag.all
    @categorys = Category.all
  end

  def edit
    @post_coffee = PostCoffee.find(params[:id])
    @tags = Tag.all
    @categorys = Category.all
  end

  def update
    @post_coffee = PostCoffee.find(params[:id])
    if @post_coffee.update(post_coffee_params)
      redirect_to post_coffee_path(@post_coffee)
    else
      render :edit
    end
  end

  def destroy
    @post_coffee = PostCoffee.find(params[:id])
    @post_coffee.destroy
    redirect_to post_coffees_path
  end

  private

  def post_coffee_params
    params.require(:post_coffee).permit(:coffee_name, :coffee_explanation, :image, :status, :tag_id, :category_id)
  end
end

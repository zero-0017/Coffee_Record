class Public::CoffeesController < ApplicationController
  before_action :authenticate_user!

  def show
    @coffee_brews = CoffeeBrew.all
    @coffees = Coffee.all
    @coffee_beans = CoffeeBean.all
    @coffee = Coffee.find(params[:id])
    @post_coffees = PostCoffee.published.where(coffee_id: @coffee.id).page(params[:page])
  end
end

class Public::CoffeeBeansController < ApplicationController
  before_action :authenticate_user!

  def show
    @coffee_brews = CoffeeBrew.all
    @coffees = Coffee.all
    @coffee_beans = CoffeeBean.all
    @coffee_bean = CoffeeBean.find(params[:id])
    @post_coffees = @coffee_bean.post_coffees.published.page(params[:page])
  end
end

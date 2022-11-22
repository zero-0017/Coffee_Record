# frozen_string_literal: true

class Public::CoffeeBrewsController < ApplicationController
  before_action :authenticate_user!

  def show
    @coffee_brews = CoffeeBrew.all
    @coffees = Coffee.all
    @coffee_beans = CoffeeBean.all
    @coffee_brew = CoffeeBrew.find(params[:id])
    @post_coffees = PostCoffee.published.where(coffee_brew_id: @coffee_brew.id).page(params[:page])
  end
end

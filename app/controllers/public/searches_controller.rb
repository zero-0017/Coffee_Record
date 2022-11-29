# frozen_string_literal: true

class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @keyword = params[:keyword]
    @post_coffees = PostCoffee.where("post_name LIKE ?", "%#{@keyword}%").published.page(params[:page])
    @coffee_brews = CoffeeBrew.all
    @coffees = Coffee.all
    @coffee_beans = CoffeeBean.all
  end
end

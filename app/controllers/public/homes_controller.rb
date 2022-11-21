# frozen_string_literal: true

class Public::HomesController < ApplicationController
  before_action :authenticate_user!, only: [:about]

  def top
  end

  def about
    @coffee_brews = CoffeeBrew.all
    @coffees = Coffee.all
    @coffee_beans = CoffeeBean.all
  end
end

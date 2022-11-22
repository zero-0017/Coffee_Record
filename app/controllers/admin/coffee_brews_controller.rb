# frozen_string_literal: true

class Admin::CoffeeBrewsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_coffee_brew, except: [:index, :create]

  def index
    @coffee_brew = CoffeeBrew.new
    @coffee_brews = CoffeeBrew.page(params[:page]).per(6)
  end

  def create
    @coffee_brew = CoffeeBrew.new(coffee_brew_params)
    if @coffee_brew.save
      redirect_to admin_coffee_brews_path, notice: "珈琲の淹れ方を作成しました"
    else
      @coffee_brews = CoffeeBrew.page(params[:page]).per(6)
      render :index
    end
  end

  def edit
  end

  def destroy
    @coffee_brew.destroy
    redirect_to admin_coffee_brews_path, alert: "珈琲の淹れ方を削除しました"
  end

  def update
    if @coffee_brew.update(coffee_brew_params)
      redirect_to admin_coffee_brews_path, notice: "珈琲の淹れ方の変更内容を保存しました"
    else
      render :edit
    end
  end

  private
    def coffee_brew_params
      params.require(:coffee_brew).permit(:coffee_brew_name)
    end

    def set_coffee_brew
      @coffee_brew = CoffeeBrew.find(params[:id])
    end
end

class Admin::CoffeesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_coffee, except: [:index, :create]

  def index
    @coffee = Coffee.new
    @coffees = Coffee.page(params[:page]).per(6)
  end

  def create
    @coffee = Coffee.new(coffee_params)
    if @coffee.save
      redirect_to admin_coffees_path, notice: "珈琲の種類を作成しました"
    else
      @coffees = Coffee.page(params[:page]).per(6)
      render :index
    end
  end

  def edit
  end

  def destroy
    @coffee.destroy
    redirect_to admin_coffees_path, alert: "珈琲の種類を削除しました"
  end

  def update
    if @coffee.update(coffee_params)
      redirect_to admin_coffees_path, notice: "珈琲の種類の変更内容を保存しました"
    else
      render :edit
    end
  end

  private
    def coffee_params
      params.require(:coffee).permit(:coffee_name)
    end

    def set_coffee
      @coffee = Coffee.find(params[:id])
    end
end

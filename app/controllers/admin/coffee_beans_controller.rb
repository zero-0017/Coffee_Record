# frozen_string_literal: true

class Admin::CoffeeBeansController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_coffee_bean, except: [:index, :create]

  def index
    @coffee_bean = CoffeeBean.new
    @coffee_beans = CoffeeBean.page(params[:page]).per(6)
  end

  def create
    @coffee_bean = CoffeeBean.new(coffee_bean_params)
    if @coffee_bean.save
      redirect_to admin_coffee_beans_path, notice: "珈琲豆の種類名を作成しました"
    else
      @coffee_beans = CoffeeBean.page(params[:page]).per(6)
      render :index
    end
  end

  def edit
  end

  def destroy
    @coffee_bean.destroy
    redirect_to admin_coffee_beans_path, notice: "珈琲豆の種類名を削除しました"
  end

  def update
    if @coffee_bean.update(coffee_bean_params)
      redirect_to admin_coffee_beans_path, notice: "珈琲豆の種類名の変更内容を保存しました"
    else
      render :edit
    end
  end

  private
    def coffee_bean_params
      params.require(:coffee_bean).permit(:coffee_bean_name)
    end

    def set_coffee_bean
      @coffee_bean = CoffeeBean.find(params[:id])
    end
end

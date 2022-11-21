# frozen_string_literal: true

class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @coffee_brews = CoffeeBrew.all
    @coffees = Coffee.all
    @coffee_beans = CoffeeBean.all
    @notifications = current_user.passive_notifications.page(params[:page]).per(13)
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end

  def destroy
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path, alert: "通知を全て削除しました"
  end
end

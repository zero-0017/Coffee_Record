class Public::NotificationsController < ApplicationController
before_action :authenticate_user!

  def index
    @tags = Tag.all
    @categorys = Category.all
    @genres = Genre.all
    @notifications = current_user.passive_notifications
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end

  def destroy
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path, alert: "通知を全て削除しました"
  end
end

class Public::NotificationsController < ApplicationController
before_action :authenticate_user!

  def index
    @tags = Tag.all
    @categorys = Category.all
    @genres = Genre.all
    @notifications = current_user.passive_notifications
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

  def destroy
    # 通知を全削除
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end
end

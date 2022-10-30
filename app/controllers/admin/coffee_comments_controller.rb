class Admin::CoffeeCommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @coffee_comments = CoffeeComment.page(params[:page]).per(3)
  end

  def destroy
    @cofee_comment = CoffeeComment.find(params[:id])
    @cofee_comment.destroy
    redirect_to request.referer, alert: "コメントを削除しました"
  end
end

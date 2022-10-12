class Admin::CoffeeCommentsController < ApplicationController
  def index
    @coffee_comments = CoffeeComment.page(params[:page]).per(11)
  end

  def destroy
    @cofee_comment = CoffeeComment.find(params[:id])
    @cofee_comment.destroy
    redirect_to request.referer, notice: "コメントを削除しました"
  end
end

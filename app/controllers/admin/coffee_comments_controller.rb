class Admin::CoffeeCommentsController < ApplicationController
  def index
    @coffee_comments = CoffeeComment.all
  end

  def destroy
    @cofee_comment = CoffeeComment.find(params[:id])
    @cofee_comment.destroy
    redirect_to request.referer
  end
end

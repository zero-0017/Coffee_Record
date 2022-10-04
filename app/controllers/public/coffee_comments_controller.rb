class Public::CoffeeCommentsController < ApplicationController

  def create
    post_coffee = PostCoffee.find(params[:post_coffee_id])
    comment = current_user.coffee_comments.new(coffee_comment_params)
    comment.post_coffee_id = post_coffee.id
    comment.save
    redirect_to request.referer
  end

  def destroy
    CoffeeComment.find(params[:id]).destroy
    redirect_to request.referer
  end

  private

  def coffee_comment_params
    params.require(:coffee_comment).permit(:comment)
  end
end

class Public::CoffeeCommentsController < ApplicationController

  def create
    @post_coffee = PostCoffee.find(params[:post_coffee_id])
    @coffee_comment = current_user.coffee_comments.new(coffee_comment_params)
    @coffee_comment.post_coffee_id = @post_coffee.id
    if @coffee_comment.save
      @post_coffee.create_notification_by(current_user)
      flash.now[:notice] = 'コメントしました'
      render :create
    else
      render :error
    end
  end

  def destroy
    @post_coffee = PostCoffee.find(params[:post_coffee_id])
    CoffeeComment.find(params[:id]).destroy
    flash.now[:alert] = 'コメントを削除しました'
    render :destroy
  end

  private

  def coffee_comment_params
    params.require(:coffee_comment).permit(:comment)
  end
end

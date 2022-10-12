class Public::CoffeeCommentsController < ApplicationController

  def create
    @post_coffee = PostCoffee.find(params[:post_coffee_id])
    comment = current_user.coffee_comments.new(coffee_comment_params)
    comment.post_coffee_id = @post_coffee.id
    if comment.save
      flash.now[:notice] = 'コメントしました'
      render :create
    else
      render :error
    end
  end

  def destroy
    @post_coffee = PostCoffee.find(params[:post_coffee_id])
    CoffeeComment.find(params[:id]).destroy
    flash.now[:notice] = 'コメントを削除しました'
    render :destroy
  end

  private

  def coffee_comment_params
    params.require(:coffee_comment).permit(:comment)
  end
end

# frozen_string_literal: true

class Public::CoffeeCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_coffee_comment, only: [:destroy]

  def create
    @post_coffee = PostCoffee.find(params[:post_coffee_id])
    @coffee_comment = current_user.coffee_comments.new(coffee_comment_params)
    @coffee_comment.post_coffee_id = @post_coffee.id
    if @coffee_comment.save
      @post_coffee.create_notification_coffee_comment(current_user)
      flash.now[:notice] = "コメントしました"
      render :create
    else
      render :error
    end
  end

  def destroy
    @post_coffee = PostCoffee.find(params[:post_coffee_id])
    CoffeeComment.find(params[:id]).destroy
    flash.now[:notice] = "コメントを削除しました"
    render :destroy
  end

  private
    def coffee_comment_params
      params.require(:coffee_comment).permit(:comment)
    end

    def correct_coffee_comment
      @coffee_comment = CoffeeComment.find(params[:id])
      @user = @coffee_comment.user
      unless @user == current_user
        redirect_to post_coffees_path, alert: "アクセス権限がありません"
      end
    end
end

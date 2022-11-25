# frozen_string_literal: true

class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_relationship

  def create
    current_user.follow(params[:user_id])
    @user.create_notification_follow(current_user)
  end

  def destroy
    current_user.unfollow(params[:user_id])
  end

  private
    def set_relationship
      @user = User.find(params[:user_id])
    end
end

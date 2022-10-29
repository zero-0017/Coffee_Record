# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in

# 会員側でログインしていて、管理者側にログインしたい場合
   def create
     if user_signed_in?
       sign_out current_user
     end
     super
   end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  def after_sign_in_path_for(resource)
    admin_path
  end

  def after_sign_out_path_for(resource_or_scope)
    new_admin_session_path
  end
end

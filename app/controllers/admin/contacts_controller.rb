class Admin::ContactsController < ApplicationController
before_action :authenticate_admin!

  def show
    @contact = Contact.find(params[:id])
  end

  def index
    @contacts = Contact.all
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      redirect_to admin_contacts_path, notice: "お問合せの変更内容を保存しました"
    else
      render :show, alert: "お問合せの変更に失敗しました"
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:status)
  end
end

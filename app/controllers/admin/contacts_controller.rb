class Admin::ContactsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @contact = Contact.find(params[:id])
  end

  def index
    @contacts = Contact.page(params[:page]).per(11)
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      redirect_to admin_contacts_path, notice: "対応状況の変更内容を保存しました"
    else
      render :show
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:status)
  end
end

class Admin::ContactsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @contact = Contact.find(params[:id])
  end

  def index
    contacts = Contact.all
    if params[:status]
      if params[:status] == "未対応"
        @contacts = Contact.where(status: "未対応").page(params[:page]).per(4)
      elsif params[:status] == "対応中"
        @contacts = Contact.where(status: "対応中").page(params[:page]).per(4)
      else
        @contacts = Contact.where(status: "対応済").page(params[:page]).per(4)
      end
    else
      @contacts = contacts.page(params[:page]).per(4)
    end
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

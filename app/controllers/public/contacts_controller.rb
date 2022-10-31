class Public::ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :sidebar_list, except: [:destroy]
  before_action :set_contact, except: [:new, :index, :create, :thank]

  def new
    @contact = Contact.new
  end

  def show
  end

  def index
    @contacts = Contact.where(user_id: current_user.id).page(params[:page]).per(4)
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.user_id = current_user.id
    if @contact.save
      redirect_to thank_contacts_path, notice: "お問合せが完了しました"
    else
      render :new
    end
  end

  def destroy
    @contact.destroy
    redirect_to contacts_path, alert: "お問合せを削除しました"
  end

  def thank
  end

  private

  def contact_params
    params.require(:contact).permit(:content, :contact_type)
  end

  def sidebar_list
    @tags = Tag.all
    @categorys = Category.all
    @genres = Genre.all
  end

  def set_contact
    @contact = Contact.find(params[:id])
  end
end

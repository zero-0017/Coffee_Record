class Public::ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :sidebar_list, except: [:destroy, :update, :create]
  before_action :set_contact, except: [:new, :index, :create, :thank]

  def new
    @contact = Contact.new
  end

  def show
  end

  def edit
  end

  def index
    @contacts = Contact.where(user_id: current_user.id)
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.user_id = current_user.id
    if @contact.save
      redirect_to thank_contacts_path, notice: "お問合せが完了しました"
    else
      render :new, alert: "お問合せに失敗しました"
    end
  end

  def update
    if @contact.update(contact_params)
      redirect_to contact_path(@contact), notice: "お問合せの変更内容を保存しました"
    else
      render :edit, alert: "お問合せの変更に失敗しました"
    end
  end

  def destroy
    @contact.destroy
    redirect_to contacts_path, notice: "お問合せを削除しました"
  end

  def thank
  end

  private

  def contact_params
    params.require(:contact).permit(:content, :inquirie_type)
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

class Public::ContactsController < ApplicationController
  before_action :authenticate_user!

  def new
    @contact = Contact.new
    @tags = Tag.all
    @categorys = Category.all
    @genres = Genre.all
  end

  def show
    @contact = Contact.find(params[:id])
    @tags = Tag.all
    @categorys = Category.all
    @genres = Genre.all
  end

  def edit
    @contact = Contact.find(params[:id])
    @tags = Tag.all
    @categorys = Category.all
    @genres = Genre.all
  end

  def index
    @contacts = Contact.where(user_id: current_user.id)
    @tags = Tag.all
    @categorys = Category.all
    @genres = Genre.all
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.user_id = current_user.id
    @tags = Tag.all
    @categorys = Category.all
    @genres = Genre.all
    if @contact.save
      redirect_to thank_contacts_path, notice: "お問合せが完了しました"
    else
      render :new, alert: "お問合せに失敗しました"
    end
  end

  def update
    @contact = Contact.find(params[:id])
    @tags = Tag.all
    @categorys = Category.all
    @genres = Genre.all
    if @contact.update(contact_params)
      redirect_to contact_path(@contact), notice: "お問合せの変更内容を保存しました"
    else
      render :edit, alert: "お問合せの変更に失敗しました"
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    redirect_to contacts_path, notice: "お問合せを削除しました"
  end

  def thank
    @tags = Tag.all
    @categorys = Category.all
    @genres = Genre.all
  end

  private

  def contact_params
    params.require(:contact).permit(:content, :inquirie_type)
  end
end

class Public::InquiriesController < ApplicationController
  before_action :authenticate_user!

  def new
    @inquirie = Inquirie.new
    @tags = Tag.all
    @categorys = Category.all
    @genres = Genre.all
  end

  def show
    @inquirie = Inquirie.find(params[:id])
    @tags = Tag.all
    @categorys = Category.all
    @genres = Genre.all
  end

  def edit
    @inquirie = Inquirie.find(params[:id])
    @tags = Tag.all
    @categorys = Category.all
    @genres = Genre.all
  end

  def index
    @inquiries = Inquirie.where(user_id: current_user.id)
    @tags = Tag.all
    @categorys = Category.all
    @genres = Genre.all
  end

  def create
    @inquirie = Inquirie.new(inquirie_params)
    @inquirie.user_id = current_user.id
    @tags = Tag.all
    @categorys = Category.all
    @genres = Genre.all
    if @inquirie.save
      redirect_to thank_inquiries_path, notice: "お問合せが完了しました"
    else
      render :new, alert: "お問合せに失敗しました"
    end
  end

  def update
    @inquirie = Inquirie.find(params[:id])
    @tags = Tag.all
    @categorys = Category.all
    @genres = Genre.all
    if @inquirie.update(inquirie_params)
      redirect_to inquiry_path(@inquirie), notice: "お問合せの変更内容を保存しました"
    else
      render :edit, alert: "お問合せの変更に失敗しました"
    end
  end

  def destroy
    @inquirie = Inquirie.find(params[:id])
    @inquirie.destroy
    redirect_to inquiries_path, notice: "お問合せを削除しました"
  end

  def thank
    @tags = Tag.all
    @categorys = Category.all
    @genres = Genre.all
  end

  private

  def inquirie_params
    params.require(:inquirie).permit(:title, :body, :inquirie_type)
  end
end

class Public::SearchsController < ApplicationController
  def search
    @post_coffees = PostCoffee.looks(params[:search], params[:word])
    @tags = Tag.all
  end
end

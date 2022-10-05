class Public::HomesController < ApplicationController
  def top
  end

  def about
    @tags = Tag.all
  end
end

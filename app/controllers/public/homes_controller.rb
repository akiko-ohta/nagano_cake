class Public::HomesController < ApplicationController
  def top
    @genres = Genre.all
    @items = Item.page(params[:page]).per(4)
    @genre = Genre.find_by(params[:genre_name])
  end

  def about
  end
end

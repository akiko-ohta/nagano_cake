class Public::HomesController < ApplicationController
  def top
    @genres = Genre.all
    @genre = Genre.find_by(name: params[:genre_name])
    @items = Item.page(params[:page]).per(4).order(created_at: :desc)
  end

  def about
  end
end

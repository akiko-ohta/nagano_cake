class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    @items = Item.page(params[:page]).per(8)
    @genre = Genre.find_by(params[:genre_name])
  end

  def show
    @genres = Genre.all
    @item = Item.find(params[:id])
    @genre = Genre.find_by(params[:genre_name])
    @cart_item = CartItem.new
  end
end
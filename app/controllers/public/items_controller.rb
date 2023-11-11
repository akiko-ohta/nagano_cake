class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    @items = Item.page(params[:page]).per(8).order(created_at: :desc)
    @genre = Genre.find_by(name: params[:genre_name])
  end

  def show
    @genres = Genre.all
    @item = Item.find(params[:id])
    @genre = Genre.find_by(name: params[:genre_name])
    @cart_item = CartItem.new
  end
end
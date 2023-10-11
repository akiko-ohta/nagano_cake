class Admin::GenresController < ApplicationController
  def new
  end

  def create
    genre = Genre.new(genre_params)
    genre.save
    redirect_to '/admin/genres'
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    genre = Genre.find(params[:id])
    genre.update(genre_params)
    redirect_to admin_genres_path
  end

  def show
  end

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def unvailable
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
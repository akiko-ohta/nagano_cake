class Public::HomesController < ApplicationController
  def top
    @genre = Genre.all
  end

  def about
  end
end

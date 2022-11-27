class Public::HomesController < ApplicationController

  def top
    @products = Product.limit(3).order("created_at DESC")
    @genres = Genre.all
  end

  def about
  end
end

class Public::ProductsController < ApplicationController

  def index
    @products = Product.all.page(params[:page]).per(8)
    @genres = Genre.all
  end

  def show
    @products = Product.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
  end

  def searches
    @genres = Genre.all
    @search_genre = params[:genre]
    @products_all = Genre.search_for(@search_genre)
    @products = Kaminari.paginate_array(Genre.search_for(@search_genre)).page(params[:page]).per(8)
  end

  def search_word
    @genres = Genre.all
  end

end

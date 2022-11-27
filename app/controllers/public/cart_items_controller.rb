class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items.all
    @total_price = CartItem.total_price(current_customer)
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_items = current_customer.cart_items.all
    @cart_items.destroy_all
    redirect_to cart_items_path
  end

  def create
    if current_customer.cart_items.find_by(product_id: cart_item_params[:product_id])
      if cart_item_params[:quantity].blank?
        @product = Product.find(cart_item_params[:product_id])
        @genres = Genre.all
        @cart_item = CartItem.new
        flash[:notice] = "個数を入力してください"
        redirect_to product_path(@product.id)
      else
        @cart_item = current_customer.cart_items.find_by(product_id: cart_item_params[:product_id])
        @cart_item.quantity = @cart_item.quantity + cart_item_params[:quantity].to_i
        @cart_item.save
        redirect_to cart_items_path
      end
    else
      if cart_item_params[:quantity].blank?
        @product = Product.find(cart_item_params[:product_id])
        @genres = Genre.all
        @cart_item = CartItem.new
        flash[:notice] = "個数を入力してください"
        redirect_to product_path(@product.id)
      else
        @cart_item = current_customer.cart_items.new(cart_item_params)
        @cart_item.save
        redirect_to cart_items_path
      end
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :quantity)
  end

end

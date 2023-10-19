class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal}
    @cart_item = CartItem.new
  end

  def update
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    @cart_items = CartItem.all
    render "index"
  end

  def destroy_all
    current_customer.cart_items = CartItem.all
    current_customer.cart_items.destroy_all
    render "index"
  end

  def create
    cart_item = CartItem.new(cart_item_params)
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item = current_customer.cart_items.find_by(amount: params[:cart_item][:amount])
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.update
      redirect_to cart_items_path
    else
      cart_item.save
      redirect_to cart_items_path
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount).merge(customer_id: current_customer.id)
  end

end
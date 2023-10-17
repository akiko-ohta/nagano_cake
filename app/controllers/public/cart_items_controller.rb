class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal}
  end

  def update
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_user.cart_items.destroy_all
    redirect_to cart_items_path
  end

  def create
    cart_item = CartItem.find_by(imte_id: params[:item_id])
    if cart_item.item_id == @cart_item.item_id
      cart_item.amount + @cart_item.amount
      cart_item.update
      redirect_to cart_items_path
    else
    cart_item = CartItem.new(cart_item_params)
    cart_item.save
    redirect_to cart_items_path
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount).merge(customer_id: current_customer.id)
  end

end

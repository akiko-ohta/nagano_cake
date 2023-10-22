class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm
    @cart_items = current_user.cartItem.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal}
  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    return if params[:order][:select_address] == "2"
      if params[:order][:select_address] == "0"
        @order.shipping_postal_code = current_customer.postal_code
        @order.shipping_address = current_customer.address
        @order.shipping_name = current_customer.first_name + current_customer.last_name
      elsif params[:order][:select_address] == "1"
        @address = Address.find(params[:order][:address_id])
        @order.shipping_postal_code = @address.postal_code
        @order.shipping_address = @address.address
        @order.shipping_name = @address.name
      end
    @order.save
    redirect_to orders_confirm_path
  end

  def index
  end

  def show
  end

  def order_params
    params.require(:order).permit(:payment_method, :shipping_postal_code, :shipping_addres, :shipping_name).merge(customer_id: current_customer.id)
  end

end

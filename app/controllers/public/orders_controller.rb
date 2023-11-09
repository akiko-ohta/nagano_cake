class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal}
    @amount_bill = @total + "800".to_i
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
  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    if @order.save
       @cart_items = current_customer.cart_items.all
       @cart_items.each do |cart_item|
         OrderDetail.create(order_id: @order.id, item_id: cart_item.item.id, price: cart_item.item.price, amount: cart_item.amount)
       end
       current_customer.cart_items.destroy_all
       redirect_to orders_complete_path
    else
      @cart_items = current_customer.cart_items.all
      @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal}
      @amount_bill = @total + "800".to_i
      @order = Order.new(order_params)
      render :confirm
    end
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = current_customer.orders.find(params[:id])
    @order_details = @order.order_details.all
    @total = @order_details.inject(0) { |sum, order_detail| sum + order_detail.subtotal}
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :shipping_postal_code, :shipping_address, :shipping_name, :amount_bill).merge(customer_id: current_customer.id)
  end
end
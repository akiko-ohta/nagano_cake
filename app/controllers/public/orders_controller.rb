class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal}
    @amount_bill = @total + "800".to_i
    @order = Order.new(order_params)
    unless params[:order][:payment_method].present?
      render :new
    end
    if params[:order][:select_address] == "0"
      @order.shipping_postal_code = current_customer.postal_code
      @order.shipping_address = current_customer.address
      @order.shipping_name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:select_address] == "1"
      if Address.exists?(params[:order][:address_id])
        @address = Address.find(params[:order][:address_id])
        @order.shipping_postal_code = @address.shipping_postal_code
        @order.shipping_address = @address.shipping_address
        @order.shipping_name = @address.shipping_name
      else
        render :new
      end
    elsif params[:order][:select_address] == "2"
      unless params[:order][:shipping_postal_code].present? && params[:order][:shipping_address].present? && params[:order][:shipping_name].present?
        render :new
      end
    end
  end

  def create
    @order = Order.new(order_params)
    @order.save
    @cart_items = current_customer.cart_items.all
    @cart_items.each do |cart_item|
      OrderDetail.create(order_id: @order.id, item_id: cart_item.item.id, price: cart_item.item.price, amount: cart_item.amount)
    end
    current_customer.cart_items.destroy_all
    redirect_to orders_complete_path
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
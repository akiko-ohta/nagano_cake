class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm
  end

  def complete
  end

  def create
    order = Order.new(order_params)
    order.save
    redirect_to confirm_orders_path
  end

  def index
  end

  def show
  end

  def order_params
    params.require(:order).permit(:payment_method, :sipping_postal_code, :sipping_addres, :sipping_name).merge(customer_id: current_customer.id)
  end

end

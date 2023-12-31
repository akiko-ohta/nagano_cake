class Public::AddressesController < ApplicationController
  def create
    address = Address.new(address_params)
    address.customer_id = current_customer.id

    if address.save
       redirect_to addresses_path
    else
      @address = Address.new
      @addresses = current_customer.addresses.all
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    address = Address.find(params[:id])
    if address.update(address_params)
       redirect_to addresses_path
    else
      @address = Address.find(params[:id])
      render :edit
    end
  end

  def index
    @address = Address.new
    @addresses = current_customer.addresses.all
  end

  private

  def address_params
    params.require(:address).permit(:shipping_postal_code, :shipping_address, :shipping_name)
  end

end
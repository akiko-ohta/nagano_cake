class Public::AddressesController < ApplicationController
  def create
    address = Address.new(address_params)
    address.save
    redirect_to addresses_path
  end

  def edit
  end

  def update
  end

  def show
  end

  def index
    @address = Address.new
    @addresses = Address.all
  end

  def destroy
  end

  private

  def address_params
    params.require(:address).permit(:shipping_postal_code, :shipping_address, :shipping_name)
  end

end

class Address < ApplicationRecord
  belongs_to :customer

  def address_display
    '〒' + shipping_postal_code + ' ' + shipping_address + ' ' + shipping_name
  end
end

class Address < ApplicationRecord
  belongs_to :customer

  def address_display
    '〒' + shipping_postal_code + ' ' + shipping_address + ' ' + shipping_name
  end

  validates :shipping_postal_code, presence: true
  validates :shipping_address, presence: true
  validates :shipping_name, presence: true
end

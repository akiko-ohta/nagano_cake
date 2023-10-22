class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order
  def amount_bill
    
  end
end

class OrderDetail < ApplicationRecord
  belongs_to :item, :order
end

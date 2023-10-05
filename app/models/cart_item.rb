class CartItem < ApplicationRecord
  belongs_to :customer, :item
end

class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  def amount_diff_max
    10
  end
  def subtotal
    item.tax_included_price * amount
  end
  def to_order_item
    OrderItem.new(item_id: item_id, tax_included_price: item.tax_included_price,
      amount: amount)
  end
end

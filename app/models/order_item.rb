class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item
  attribute :production_status, :integer, default: 0
  enum production_status: { disabled: 0, wait_for_production: 1,
    in_production: 2, completed: 3 }
  def subtotal
    tax_included_price * amount
  end
end

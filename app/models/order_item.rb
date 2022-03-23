class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item
  attribute :production_status, :integer, default: 0
  enum production_status: { disabled: 0, wait_for_production: 1,
    in_production: 2, completed: 3 }

  def valid_status
    valid_status_nums.map{|vn| OrderItem.production_statuses.key(vn) }
  end

  def valid_status_nums
    ps_num = OrderItem.production_statuses[production_status]
    return [0] if ps_num == 0
    return [1, 2, 3]
  end

  def subtotal
    tax_included_price * amount
  end
end

class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items

  attribute :order_status, :integer, default: 0

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum order_status: { wait_for_deposit: 0, confirmed_deposit: 1, in_production: 2, in_packing: 3, shipped: 4 }

  def address_display(with_name)
    "〒#{postal_code} #{address}" + (with_name ? " #{name}" : "")
  end
  
  def payment
    get_payment_str(payment_method)
  end
  def get_payment_str(param)
    Order.payment_methods_i18n[param]
  end

  def od_status
    get_order_status(order_status)
  end
  def get_order_status(param)
    Order.order_statuses_i18n[param]
  end

  def amount
    order_items.map{|i| i.amount}.sum
  end
end

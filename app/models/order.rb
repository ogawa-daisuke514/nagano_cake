class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items

  attribute :order_status, :integer, default: 0
  attribute :payment_method, :integer, default: 0

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum order_status: { wait_for_deposit: 0, confirmed_deposit: 1, in_production: 2, in_packing: 3, shipped: 4 }

  validates :name, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :postage, presence: true
  validates :total_fee, presence: true
  validates :payment_method, presence: true

  def production_order_status
    ois = order_items.map{|oi| OrderItem.production_statuses[oi.production_status] }
    return 1 if ois.max <= 1
    return 3 if ois.min >= 3
    return 2
  end

  def valid_status_nums
    os_num = Order.order_statuses[order_status]
    return [0, 1] if os_num == 0
    case production_order_status
    when 1
      return [0, 1]
    when 2
      return [2]
    when 3
      return [3, 4]
    end
  end

  def valid_status
    valid_status_nums.map{|vn| Order.order_statuses.key(vn) }
  end

  def now_postage
    800
  end

  def address_valid?
    @address.present? && @postal_code.present? && @name.present?
  end

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

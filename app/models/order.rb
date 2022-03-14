class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items

  def amount
    order_items.map{|i| i.amount}.sum
  end
end

class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :genre
  has_many :cart_items
  has_many :order_items

  def tax_rate
    1.1
  end

  def tax_included_price
    (price * tax_rate).floor
  end

  def get_image(w, h)
    image.variant(resize_to_limit: [w, h]).processed
  end

  def status
    get_status_string(is_active)
  end

  def get_status_string(active)
    active ? "販売中" : "販売停止中"
  end

end

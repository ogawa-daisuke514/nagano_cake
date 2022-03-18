class Address < ApplicationRecord
  belongs_to :customer
  def address_one_line
    address_display(true)
  end
  def address_display(with_name)
    "〒#{postal_code} #{address}" + (with_name ? " #{name}" : "")
  end
end

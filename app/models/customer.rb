class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :cart_items
  has_many :orders
  has_many :addresses

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :first_name_kana, presence: true
  validates :last_name_kana, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :telephone_number, presence: true

  def address_display(with_name)
    "〒#{postal_code} #{address}" + (with_name ? " #{name}" : "")
  end

  def full_name
    last_name + first_name
  end

  def status
    get_status_string(is_active)
  end

  def get_status_string(active)
    active ? "有効" : "退会"
  end

end

class Order < ApplicationRecord
  belongs_to :user
  has_many :product_lists
  accepts_nested_attributes_for :product_lists

  validates :billing_name, presence: true
  validates :billing_address, presence: true
  validates :shipping_name, presence: true
  validates :shipping_address, presence: true

  before_create :generate_token

  def generate_token
    self.token = SecureRandom.hex(8)
  end

  def to_param
    token
  end
end

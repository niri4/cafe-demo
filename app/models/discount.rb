class Discount < ApplicationRecord
  has_many :orders
  validates :product_ids,  presence: true, length: {
    minimum: 2,
    message: 'Minimum 2 products are required'
  }
  validates :value, presence: true, numericality: { 
    only_float: true,
    greater_than: 0,
    less_than: 100
  }

  before_validation :product_compact

  private
  
  def product_compact
    self.product_ids&.compact!
  end
end

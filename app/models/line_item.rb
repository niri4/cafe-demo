class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  belongs_to :customer
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :tax, numericality: { only_float: true, greater_than_or_equal_to: 0 }
  validates :total, numericality: { only_float: true, greater_than_or_equal_to: 0 }

  before_save :calculate_total

  def calculate_total
    product = self.product
    if product.free
      self.total = 0
      self.tax = 0
    elsif product.vat.zero?
      self.total = product.price.to_f * self.quantity.to_f
      self.tax = 0
    else
      tax_value = (product.price.to_f * product.vat.to_f)/ 100
      self.tax = self.quantity.to_f * tax_value
      self.total = (self.quantity.to_f * product.price.to_f) + self.tax.to_f
    end
  end
end

class Order < ApplicationRecord
  enum status: { cart: 0, paid: 1, completed: 2 }
  has_many :line_items, dependent: :destroy
  has_many :customers, through: :line_items
  has_many :products, through: :line_items
  belongs_to :discount, optional: true
  validates :discount_value, numericality: { only_float: true, greater_than_or_equal_to: 0 }
  validates :total, numericality: { only_float: true, greater_than_or_equal_to: 0 }

  def modify
    self.total = self.line_items.sum("CAST(COALESCE(total, '0') AS DECIMAL)").to_s
    discount = Discount.where("product_ids <@ ARRAY[?]", self.product_ids)&.first
    if discount.present?
      self.discount = discount
      self.discount_value = ((self.total.to_f * discount.value.to_f)/100)
      order_total = self.total.to_f - self.discount_value.to_f
      self.total = [order_total, 0].max
    end
    self.save
  end

  def placed
    if self.total.to_f <= self.customers.first.funds.to_f
      self.status = "paid"
      funds = self.customers.first.funds.to_f - self.total.to_f
      self.customers.update(funds: funds)
      self.line_items.each do |line_item|
        pro = line_item.product
        quantity = pro.quantity - line_item.quantity
        quantity = [quantity, 0].max
        pro.update(quantity: quantity)
      end
      self.save
    else
      self.errors.add(:base, "order total exceed the customer funds")
    end
  end
end

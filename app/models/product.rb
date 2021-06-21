class Product < ApplicationRecord
  belongs_to :category
  validates :title,  presence: true
  validates :status,  presence: true
  validates :vat,  presence: true
  validates :quantity,  presence: true
  validates :price,  presence: true
  enum status: { draft: 0, published: 1, unavailable: 2 }
  validates :price, numericality: { only_float: true, greater_than_or_equal_to: 0 }
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :vat, numericality: { only_integer: true, greater_than_or_equal_to: 0,  less_than: 100 }
  has_one_attached :image
  has_many :line_items

  def self.active
    where(status: "published")
  end
end

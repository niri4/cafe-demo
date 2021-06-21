class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name,  presence: true
  validates :email,  presence: true
  validates :funds, numericality: { only_float: true, greater_than_or_equal_to: 0 }
  has_many :line_items

  has_many :orders,-> { distinct }, through: :line_items
end

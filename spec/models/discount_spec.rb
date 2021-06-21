# frozen_string_literal: true

require "rails_helper"

RSpec.describe Discount, type: :model do  
  context "associations" do
    it { should have_many(:orders) }
  end

  context "validations" do
    it { should validate_presence_of(:product_ids) }
    it { should validate_presence_of(:value) }
    it { should validate_numericality_of(:value).is_greater_than(0).is_less_than(100) }
  end
end
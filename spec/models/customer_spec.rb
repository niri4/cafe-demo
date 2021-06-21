# frozen_string_literal: true

require "rails_helper"

RSpec.describe Customer, type: :model do  
  context "associations" do
    it { should have_many(:orders) }
    it { should have_many(:line_items) }
  end

  context "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_numericality_of(:funds).is_greater_than_or_equal_to(0) }
  end
end
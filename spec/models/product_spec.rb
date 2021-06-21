# frozen_string_literal: true

require "rails_helper"

RSpec.describe Product, type: :model do
  context "associations" do
    it { should have_many(:line_items) }
    it { should belong_to(:category) }
  end

  context "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:status) }
    it { should define_enum_for(:status).with_values(draft: 0, published: 1, unavailable: 2) }
    it { should validate_presence_of(:vat) }
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(0).only_integer }
    it { should validate_numericality_of(:vat).is_greater_than_or_equal_to(0).is_less_than(100).only_integer }
  end

  context ".active" do
    let(:category) { create(:category) }
    let!(:product) { create(:product, status: "published", category: category) }
    let!(:product1) { create(:product, status: "draft", category: category) }
    it "should display only published products" do
      expect(Product.active.count).to eq(1)
    end
  end
end

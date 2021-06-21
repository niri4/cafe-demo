# frozen_string_literal: true

require "rails_helper"

RSpec.describe LineItem, type: :model do  
  context "associations" do
    it { should belong_to(:order) }
    it { should belong_to(:product) }
    it { should belong_to(:customer) }
  end

  context "validations" do
    it { should validate_numericality_of(:quantity).is_greater_than(0).only_integer }
    it { should validate_numericality_of(:tax).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:total).is_greater_than_or_equal_to(0) }
  end

  context "callbacks" do
    context "before_save" do
      it "should save tax and total as zero if product is free" do
        customer = create(:customer, email: "abc@cafe.com", first_name: "ss", password: "password", password_confirmation: "password", funds: "0")
        category = create(:category)
        product = create(:product, status: "published", category: category, free: true)
        line_item = order_creation(customer, product)
        expect(line_item.total).to eq("0")
        expect(line_item.tax).to eq("0")
      end

      it "should save tax as zero and total if product is tax free" do
        customer = create(:customer, email: "abc@cafe.com", first_name: "ss", password: "password", password_confirmation: "password", funds: "0")
        category = create(:category)
        product = create(:product, status: "published", category: category, vat: 0, price: "100")
        line_item = order_creation(customer, product)
        expect(line_item.total).to eq(product.price.to_f.to_s)
        expect(line_item.tax).to eq("0")
      end

      it "should save tax and total as sum of price and tax if product is tax free" do
        customer = create(:customer, email: "abc@cafe.com", first_name: "ss", password: "password", password_confirmation: "password", funds: "0")
        category = create(:category)
        product = create(:product, status: "published", category: category, vat: 10, price: "100")
        line_item = order_creation(customer, product)
        expect(line_item.total).to eq("110.0")
        expect(line_item.tax).to eq("10.0")
      end
    end
  end

  def order_creation(customer, product)
    order = customer.orders.where(status: "cart").where("line_items.product_id = ?", product.id).first
    unless order.present?
      order = Order.find_or_initialize_by(status: "cart")
      line_item = order.line_items.new
      line_item.product_id = product.id
      line_item.quantity = 1
      line_item.customer = customer
      order.save
    end
    line_item
  end
end

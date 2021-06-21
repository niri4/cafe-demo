# frozen_string_literal: true

require "rails_helper"

RSpec.describe Order, type: :model do
  context "associations" do
    it { should have_many(:line_items) }
    it { should belong_to(:discount).optional }
    it { should have_many(:customers) }
    it { should have_many(:products) }
  end

  context "validations" do
    it { should validate_numericality_of(:total).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:discount_value).is_greater_than_or_equal_to(0) }
  end

  context "#modify" do
    it "should show discount value 0 if discount not applied" do
      customer = create(:customer, email: "abc@cafe.com", first_name: "ss", password: "password", password_confirmation: "password", funds: "0")
      category = create(:category)
      product = create(:product, status: "published", category: category, vat: 10, price: "100")
      order = order_creation(customer, product)
      order.modify
      expect(order.total).to eq("110.0")
      expect(order.discount_value).to eq("0")
      expect(order.discount_id).to eq(nil)
    end

    it "should discount value 0 if discount applied" do
      customer = create(:customer, email: "abc@cafe.com", first_name: "ss", password: "password", password_confirmation: "password", funds: "0")
      category = create(:category)
      product = create(:product, status: "published", category: category, vat: 10, price: "100")
      product2 = create(:product, status: "published", category: category, vat: 10, price: "100")
      discount = Discount.create(product_ids: [product.id, product2.id], value: 10)
      order = order_creation(customer, product)
      order = order_creation(customer, product2)
      order.modify
      expect(order.total).to eq("198.0")
      expect(order.discount_value).to eq("22.0")
      expect(order.discount_id).to eq(discount.id)
    end
  end

  context "#placed" do
    it "should not placed order if order total is less than funds" do
      customer = create(:customer, email: "abc@cafe.com", first_name: "ss", password: "password", password_confirmation: "password", funds: "0")
      category = create(:category)
      product = create(:product, status: "published", category: category, vat: 10, price: "100")
      order = order_creation(customer, product)
      order.modify
      order.placed
      expect(order.errors.messages[:base].first).to eq("order total exceed the customer funds")
    end

    it "should not placed order if order total is less than funds" do
      customer = create(:customer, email: "abc@cafe.com", first_name: "ss", password: "password", password_confirmation: "password", funds: "500")
      category = create(:category)
      product = create(:product, status: "published", category: category, vat: 10, price: "100", quantity: 100)
      order = order_creation(customer, product)
      order.modify
      order.placed
      expect(order.status).to eq("paid")
      expect(customer.reload.funds).to eq("390.0")
      expect(product.reload.quantity).to eq(99)
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
    order
  end
end

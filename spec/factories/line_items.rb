FactoryBot.define do
  factory :line_item do
    total { "0" }
    tax { "0" }
    product_id {  }
    quantity { 1 }
    customer_id { }
    order_id { }
  end
end
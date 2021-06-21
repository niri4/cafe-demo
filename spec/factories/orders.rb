FactoryBot.define do
  factory :order do
    total { "0" }
    discount_value { }
    discount_id {  }
    status { "cart" }
  end
end
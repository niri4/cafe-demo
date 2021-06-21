FactoryBot.define do
  factory :discount do
    title { Faker::Name.name }
    product_ids { [] }
    value { 5 }
  end
end
FactoryBot.define do
  factory :product do
    title { Faker::Name.name }
    vat { "0" }
    price { "100" }
    quantity { 5 }
    status { "published" }
  end
end
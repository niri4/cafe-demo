FactoryBot.define do
  factory :customer do
    first_name { Faker::Name.name }
    email { Faker::Name.name }
  end
end
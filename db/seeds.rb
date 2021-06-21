AdminUser.create!(email: 'admin@cafe.com', password: 'password', password_confirmation: 'password')

category1 = Category.create(name: "Bevrages")

category2 = Category.create(name: "Sandwhiches")
puts ">>>>>> categories created"

category1.products.create(title: "Hot Coffee", vat: 10, quantity: 100, status: "published", price: "100", description: "Delicious Hot cofee")
cold_drink = category1.products.create(title: "Pepsi",
	vat: 5,
	quantity: 100,
	status: "published",
	price: "40",
	description: "2 Ml soft drink",
	detail: "this is cold bevarage"
)

chicken_sand = category2.products.create(title: "Grilled chicken sandwhich",
  vat: 10,
  quantity: 100,
  status: "published",
  price: "150",
  description: "made of best quality chicken"
)
category2.products.create(title: "Veg sandwhich",
  vat: 0,
  quantity: 200,
  status: "published",
  price: "150",
  description: "2 Ml soft drink",
  detail: "this is veg sandwhich"
)

puts ">>>>>> products created"

Discount.create(title: "10% discount order with cold drink with chicken sandwhich", product_ids: [chicken_sand.id, cold_drink.id], value: 10)

puts ">>>>>> discount created"

Customer.create(first_name: "Jhon", last_name: "Doe", password: "password", password_confirmation: "password", email: "user@cafe.com", funds: "500")
Customer.create(first_name: "Jhof", password: "password", password_confirmation: "password", email: "user1@cafe.com", funds: "0")


puts ">>>>>> customer created"
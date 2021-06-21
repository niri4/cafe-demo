# README
## Cafe

### Acceptance
- A day at a coffee shop!
- A customer visits a coffee shop that sells a bunch of items (e.g. beverages, sandwiches etc.).
- Items have varying tax rates and some are free or offered at a discount when ordered with another item.
- The customer is made aware of the order total and once he pays for it, he can wait until notified of the order completion.
- You are required to describe a program that with a set of interfaces that models the above problem at hand.

### setup:

```
rails db:prepare
```

or

```
rails db:create
rails db:migrate
rails db:seed
```

- To boot rails server

```
rails s
```

- To run the test cases using rspec

```
rspec
```

### Asumptions
- The Discount applied on order total
- The One Discount applied on a order
- The Discount applied on product not on product's quantity
- Before any order to proceed there should be sufficent funds in customer account
- Funds are added by admin only
- In UI add fund disable is present as coming soon feature
- Admin has access to create categories, product, discount and customer
- Order are added to cart first and then order valid for payment
- when customer paid the oirder it fund got deducted and refelect in header funds section
- Once order is placed admin has access to complete the order
- Discount are automatically applied on customer checkout

### Credentails

 Admin section

```
http://localhost:3000/admin

email - admin@cafe.com
password - password
```

 Storefront section

```
http://localhost:3000
```

Some inbuild customer
customer with funds

```
email -  user@cafe.com
password - password
```
customer without funds

```
email - user1@cafe.com
password - password
```
FactoryGirl.define do
  sequence(:email) { |n| "test#{n}@test.com" }

  factory :user do
    email
    password '123456'
    password_confirmation { password }
  end

  factory :product do
    title 'Product Name'
    description 'Description.'
    quantity 5
    price 100
  end

  factory :order do
    total_price '1000'
    billing_name 'test'
    billing_address 'xx road'
    shipping_name 'test'
    shipping_address 'xx road'
    association :user
  end

  factory :cart do
  end

  factory :cart_item do
    quantity 3
    association :product
    association :cart
  end

  factory :product_list do
    product_name 'Product Name'
    product_price 100
    quantity '5'
    association :product
    association :order
  end
end

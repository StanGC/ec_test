FactoryGirl.define do
  factory :user do
    email 'test@test.com'
    password '123456'
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
  end

  factory :cart do
  end

  factory :cart_item do
    quantity 3
    association :product
    association :cart
  end
end

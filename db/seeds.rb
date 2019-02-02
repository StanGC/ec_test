# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(
  id: 1,
  email: 'test@test.com',
  password: '123456',
  password_confirmation: '123456'
)

10.times do
  title = Faker::Lorem.word
  attrs = {
    description: Faker::Lorem.paragraph,
    quantity: Faker::Number.number(3).to_i,
    price: Faker::Number.number(4).to_i,
  }
  Product.create_with(attrs).find_or_create_by(title: title)
end

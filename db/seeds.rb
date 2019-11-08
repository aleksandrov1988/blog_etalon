# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin_password = 'aMai2oo9'
user = User.create!(name: 'Администратор', login: 'admin', password: admin_password, password_confirmation: admin_password, admin: true)
100.times do
  user.posts.create!(title: Faker::Lorem.sentence, user: user, body: Faker::Lorem.paragraph)
end

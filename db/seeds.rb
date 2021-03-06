# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
60.times do |n|
  name =  "TestUser_" + n.to_s
  email = "TestUser_" + n.to_s + "@test.jp"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               )

  #状況確認用に「puts」をつけてみた
  puts n.to_s
end

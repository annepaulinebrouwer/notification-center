# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
puts "Cleaning database..."
User.destroy_all

puts "Creating admin user"
User.create(
  email: "admin@inyova.com",
  password: "amazing_password",
  admin: true
)

puts "Creating two clients"
User.create(
  email: "paula@gmail.com",
  password: "testtest"
)

User.create(
  email: "anne@gmail.com",
  password: "test1234"
)

puts "Finished"

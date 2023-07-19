# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
puts "Cleaning database..."
User.destroy_all
Notification.destroy_all

puts "Creating admin user and two clients"
User.create(
  email: "admin@inyova.com",
  password: "amazing_password",
  admin: true
)

paula = User.create(
  email: "paula@gmail.com",
  password: "testtest"
)

anne = User.create(
  email: "anne@gmail.com",
  password: "test1234"
)

puts "Creating two notifications"
invest_today = Notification.create(
  title: "Invest today",
  description: "We added new sustainable companies to our portofolio. Check it out!",
  date: Date.tomorrow.at_noon
)

birthday = Notification.create(
  title: "Birthday Present",
  description: "Happy Birtday! We have special discount for you.",
  date: Date.today.advance(days: 2).noon
)

puts "Assigning notifications to users"
invest_today.user_notifications.create(user_id: paula.id)
invest_today.user_notifications.create(user_id: anne.id)
birthday.user_notifications.create(user_id: paula.id)

puts "Finished"

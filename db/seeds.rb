# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.create(description: "guest")
Role.create(description: "owner")


Plan.create(duration: 1, price: 0, active: true, name: '30 Day Trial', free: true)
Plan.create(duration: 1, price: 50, active: true, name: 'Bronze Package', free: false)
Plan.create(duration: 3, price: 150, active: true, name: 'Silver Package', free: false)
Plan.create(duration: 6, price: 300, active: true, name: 'Gold Package', free: false)
Plan.create(duration: 12, price: 600, active: true, name: 'Platinum Package', free: false)






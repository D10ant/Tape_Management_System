# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

customers = Customer.create([{tla: 'ABC', name: 'AB Corporations'}, {tla: 'LUK', name: 'Logicalis UK'}])
locations = Location.create([{location: 'Slough'}, {location: 'Bracknell'}])
tapes = Tape.create([{reference: '123TAPE', customer_id: Customer.first.id}, {reference: '456Tape', customer_id: Customer.last.id}])
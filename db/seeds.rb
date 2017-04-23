# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Product.delete_all()
Product.create(id: 1, title: 'shirt', price: 50.55, available_inventory: 4)
Product.create(id: 2,title: 'shoes', price: 150.55, available_inventory: 54)
Product.create(id: 3,title: 'hat', price: 29.99, available_inventory: 0)
Product.create(id: 4,title: 'shorts', price: 45.99, available_inventory: 8)
Product.create(id: 5,title: 'bag', price: 90.22, available_inventory: 10)

User.delete_all()
User.create(id: 1, name: 'Anya')
User.create(id: 2, name: 'Mimi')

CartItem.delete_all()
Cart.delete_all()

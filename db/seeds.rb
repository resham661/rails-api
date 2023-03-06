# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Product.create([
  {name: 'Star Wars', brand: "Zara", price: 500},
  {name: 'Bags', brand: "Wildcraft", price: 5000},
  {name: 'Earphone', brand: "Boat", price: 2000},
  {name: 'Laptop', brand: "Lenovo", price: 65000},
])

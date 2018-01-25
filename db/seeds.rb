# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

landscape = Category.create!(name: 'Landscape')
landscape.subjects.create!(name: 'Plimmerton Beach')

macro = Category.create!(name: 'Macro')
macro.subjects.create!(name: 'Ant')
macro.subjects.create!(name: 'Bee')

nature = Category.create!(name: 'Nature')
nature.subjects.create!(name: 'Black-backed Gull')
nature.subjects.create!(name: 'Tui')

people = Category.create!(name: 'People')
people.subjects.create!(name: 'Mother')

pets = Category.create!(name: 'Pets')
pets.subjects.create!(name: 'Cat')

urban = Category.create!(name: 'Urban')
urban.subjects.create!(name: 'Te Papa')

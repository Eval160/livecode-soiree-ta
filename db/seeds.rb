# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
require "open-uri"

def clear_database
  puts "🧽 Nettoyage de la base de données..."
  User.destroy_all
  Cat.destroy_all
  puts "💀 Base de données nettoyée avec succès !"
end

def create_user
  puts "🥷 Create user Toto"
  User.create!(email: "toto@mail.com", password: "azerty")
  puts "✅ Toto created"
end

def create_cats
 file_path = Rails.root.join('db', 'cats.json')
 parsed_cats = JSON.parse(File.read(file_path))
 parsed_cats.each do |cat|
  puts "🐈 Create a cat"
  image_file = URI.open(cat["url"])
  cat = Cat.new(
    name: Faker::Creature::Cat.name,
    breed: cat.dig("breeds", 0, "name")
  )
  cat.photo.attach(io: image_file, filename: "#{cat.name.parameterize}.png", content_type: "image/png")
  cat.save!
  puts "✅  #{cat.name} created!"
 end
end

clear_database
create_user
create_cats

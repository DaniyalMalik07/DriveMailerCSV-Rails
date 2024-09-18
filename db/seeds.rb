# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

# Seed 1000 schools using find_or_create_by to avoid duplicates
1000.times do
  School.find_or_create_by!(
    name: Faker::University.name,
    short_name: Faker::Educator.campus,
    location: "#{Faker::Address.street_address}, #{Faker::Address.zip_code}",
    city: Faker::Address.city,
    state: Faker::Address.state
  )
end

puts '1000 schools have been successfully created'

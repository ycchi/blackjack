# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

SUITS = ["♠", "♥", "♦", "♣"]
RANKS = {
  "A" => 11,
  "2" => 2,
  "3" => 3,
  "4" => 4,
  "5" => 5,
  "6" => 6,
  "7" => 7,
  "8" => 8,
  "9" => 9,
  "10" => 10,
  "J" => 10,
  "Q" => 10,
  "K" => 10
}

SUITS.each do |suit|
  RANKS.each do |rank, value|
    Card.find_or_create_by!(name: "#{rank}#{suit}") do |card|
      card.value = value
      card.used = false
    end
  end
end

class RoundController < ApplicationController
  def index
    Card.update_all(used: false)
    puts "card deck reset complete"
    @dealer_cards = []
    @player_cards = []
  end
end

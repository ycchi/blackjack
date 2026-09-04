class RoundController < ApplicationController
  def index
    result = Round::RoundService.new.new_game
    @dealer_cards = result[:dealer_cards]
    @player_cards = result[:player_cards]
  end
end

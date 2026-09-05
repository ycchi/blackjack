class RoundController < ApplicationController
  def index
    result = Round::RoundService.new.new_game
    @dealer_cards = result[:dealer_cards]
    @player_cards = result[:player_cards]
    @player_blackjack = result[:player_blackjack]
  end

  def hit
    service = Round::RoundService.new
    player_cards = PlayerCard.includes(:card).map(&:card)
    result = service.hit(player_cards, PlayerCard)
    @player_cards = result[:cards]
    @bust = result[:bust]
    @sum = result[:sum]
    @dealer_cards = service.dealer_hand
  end

  def stand
    @player_cards = PlayerCard.includes(:card).map(&:card)
    @dealer_cards = Round::RoundService.new.dealer_hand(reveal: true)
  end
end

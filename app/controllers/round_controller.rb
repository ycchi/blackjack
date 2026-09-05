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
    service = Round::RoundService.new
    @player_cards = PlayerCard.includes(:card).map(&:card)
    player_sum = service.values_sum(@player_cards)

    dealer_result = service.dealer_play
    @dealer_cards = dealer_result[:cards]

    if dealer_result[:sum] > 21
      @outcome = "Dealer Bust, You Win"
    elsif dealer_result[:sum] < player_sum
      @outcome = "You Win"
    elsif dealer_result[:sum] == player_sum
      @outcome = "Push"
    else
      @outcome = "Dealer Win"
    end
  end
end

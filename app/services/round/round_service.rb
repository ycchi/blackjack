module Round
  class RoundService
    def initialize
    end

    def new_game
      reset
      @player_cards = draw_cards(2)
      @player_cards.each { |card| PlayerCard.create!(card_fk: card.id) }

      @dealer_cards = draw_cards(2)
      @dealer_cards.each_with_index do |card, index|
        DealerCard.create!(card_fk: card.id, hole_card: index == 1)
      end
      face_down_hole_card

      { dealer_cards: @dealer_cards, player_cards: @player_cards, player_blackjack: check_blackjack(@player_cards) }
    end

    def reset
      Card.update_all(used: false)
      DealerCard.delete_all
      PlayerCard.delete_all
    end

    def draw_cards(num_cards)
      cards = Card.where(used: false).order(Arel.sql("RANDOM()")).limit(num_cards)
      cards.update_all(used: true)
      cards.to_a
    end

    def dealer_hand(reveal: false)
      DealerCard.includes(:card).order(:id).map do |dealer_card|
        !reveal && dealer_card.hole_card? ? Card.new(name: "", value: 0) : dealer_card.card
      end
    end

    # Store and replace dealer's hole card (face-down) with placeholder to be revealed after player's turn
    def face_down_hole_card
      placeholder = Card.new(name: "", value: 0)
      @dealer_cards[1] = placeholder
    end

    def hit(cards, card_model)
      new_card = draw_cards(1)
      card_model.create!(card_fk: new_card.first.id)
      cards += new_card
      sum = values_sum(cards)
      has_ace = check_ace(cards)

      if has_ace && 21 < sum
        cards = ace_to_1(cards)
        sum = values_sum(cards)
      end

      bust = 21 < sum

      { cards: cards, sum: sum, bust: bust }
    end

    def values_sum(cards)
      cards.sum { |card| card[:value] }
    end

    def check_ace(cards)
      # check if the cards contain an A (value of 11), and return boolean
      cards.any? { |card| card[:value] == 11 }
    end

    def ace_to_1(cards)
      ace = cards.find { |card| card[:value] == 11 }
      if ace
        ace[:value] = 1
      end
      cards
    end

    def check_blackjack(cards)
      (check_ace(cards) && values_sum(cards) == 21) ? true : false
    end
  end
end

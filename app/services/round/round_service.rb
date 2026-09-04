module Round
  class RoundService
    def initialize
    end

    def new_game
      reset
      shuffle_order
      @player_cards = distribute_cards(2)
      @dealer_cards = distribute_cards(2)
      { dealer_cards: @dealer_cards, player_cards: @player_cards }
    end

    def reset
      Card.update_all(used: false)
    end

    def shuffle_order
      @shuffled_order = Card.where(used: false).pluck(:id).shuffle
    end

    def distribute_cards(num_cards)
      ids = @shuffled_order.shift(num_cards)
      cards = Card.where(id: ids)
      cards.update_all(used: true)
      cards
    end
  end
end

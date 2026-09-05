class PlayerCard < ApplicationRecord
  belongs_to :card, foreign_key: :card_fk
end

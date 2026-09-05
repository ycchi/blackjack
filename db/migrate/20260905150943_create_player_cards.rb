class CreatePlayerCards < ActiveRecord::Migration[8.1]
  def change
    create_table :player_cards do |t|
      t.integer :card_fk

      t.timestamps
    end

    add_foreign_key :player_cards, :cards, column: :card_fk
  end
end

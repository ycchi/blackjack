class CreateDealerCards < ActiveRecord::Migration[8.1]
  def change
    create_table :dealer_cards do |t|
      t.integer :card_fk
      t.boolean :hole_card

      t.timestamps
    end

    add_foreign_key :dealer_cards, :cards, column: :card_fk
  end
end

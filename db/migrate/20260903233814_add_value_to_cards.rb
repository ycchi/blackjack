class AddValueToCards < ActiveRecord::Migration[8.1]
  def change
    add_column :cards, :value, :integer
  end
end

class CreateCoffeeGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :coffee_genres do |t|
      t.integer :post_coffee_id, null: false
      t.integer :genre_id, null: false
      t.timestamps
    end
  end
end

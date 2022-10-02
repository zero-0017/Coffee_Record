class CreateCoffeeComments < ActiveRecord::Migration[6.1]
  def change
    create_table :coffee_comments do |t|
      t.integer :user_id, null: false
      t.integer :post_coffee_id, null: false
      t.string :coffee_comment, null: false
      t.timestamps
    end
  end
end

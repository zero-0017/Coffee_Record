# frozen_string_literal: true

class CreatePostCoffees < ActiveRecord::Migration[6.1]
  def change
    create_table :post_coffees do |t|
      t.integer :user_id, null: false
      t.integer :coffee_brew_id, null: false
      t.integer :coffee_id, null: false
      t.string :post_name, null: false
      t.text :post_explanation, null: false
      t.integer :status, default: 0, null: false
      t.timestamps
    end
  end
end

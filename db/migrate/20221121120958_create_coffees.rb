# frozen_string_literal: true

class CreateCoffees < ActiveRecord::Migration[6.1]
  def change
    create_table :coffees do |t|
      t.string :coffee_name, null: false
      t.timestamps
    end
  end
end

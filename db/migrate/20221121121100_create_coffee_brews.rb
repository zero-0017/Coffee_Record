# frozen_string_literal: true

class CreateCoffeeBrews < ActiveRecord::Migration[6.1]
  def change
    create_table :coffee_brews do |t|
      t.string :coffee_brew_name, null: false
      t.timestamps
    end
  end
end

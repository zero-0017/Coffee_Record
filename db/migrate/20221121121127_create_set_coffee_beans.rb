# frozen_string_literal: true

class CreateSetCoffeeBeans < ActiveRecord::Migration[6.1]
  def change
    create_table :set_coffee_beans do |t|
      t.integer :post_coffee_id, null: false
      t.integer :coffee_bean_id, null: false
      t.timestamps
    end
  end
end

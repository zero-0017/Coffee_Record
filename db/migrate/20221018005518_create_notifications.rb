# frozen_string_literal: true

class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :visiter_id, null: false
      t.integer :visited_id, null: false
      t.integer :post_coffee_id
      t.string :action, null: false
      t.boolean :checked, default: false, null: false
      t.timestamps
    end
  end
end

class CreatePostCoffees < ActiveRecord::Migration[6.1]
  def change
    create_table :post_coffees do |t|
      t.string :coffee_name, null: false
      t.text :coffee_explanation, null: false
      t.string :status, null: false
      t.timestamps
    end
  end
end

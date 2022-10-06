class CreatePostCoffees < ActiveRecord::Migration[6.1]
  def change
    create_table :post_coffees do |t|
      t.integer :user_id, null: false
      t.integer :tag_id, null: false
      t.integer :category_id, null: false
      t.string :coffee_name, null: false
      t.text :coffee_explanation, null: false
      t.string :status, null: false
      t.timestamps
    end
  end
end

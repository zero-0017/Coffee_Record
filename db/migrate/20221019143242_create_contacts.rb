class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.integer :user_id, null: false
      t.text :content, null: false
      t.integer :contact_type, default: 0, null: false
      t.integer :status, default: 0, null: false
      t.timestamps
    end
  end
end

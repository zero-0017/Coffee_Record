class CreateCoffeeBeans < ActiveRecord::Migration[6.1]
  def change
    create_table :coffee_beans do |t|
      t.string :coffee_bean_name, null: false
      t.timestamps
    end
  end
end

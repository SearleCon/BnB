class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.integer :duration
      t.decimal :price
      t.boolean :active

      t.timestamps
    end
  end
end

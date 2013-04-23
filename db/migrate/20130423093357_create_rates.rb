class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.decimal :price
      t.boolean :per_person
      t.boolean :per_room
      t.boolean :active
      t.string :name
      t.references :rateable, polymorphic: true
      t.integer :rate_type_id
      t.timestamps
    end
  end
end

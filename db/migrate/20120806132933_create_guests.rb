class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :name
      t.string :surname
      t.string :contact_number

      t.timestamps
    end
  end
end

class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.string :description
      t.integer :value
      t.integer :booking_id

      t.timestamps
    end
  end
end

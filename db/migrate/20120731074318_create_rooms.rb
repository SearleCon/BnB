class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :description
      t.boolean :en_suite
      t.float :rates
      t.string :extras

      t.timestamps
    end
  end
end

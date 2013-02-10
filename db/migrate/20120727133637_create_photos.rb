class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :description
      t.string :image
      t.integer :order

      t.timestamps
    end
  end
end

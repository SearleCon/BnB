class AddSlugToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :slug, :string
    add_index :guests , :slug, unique: true
  end
end

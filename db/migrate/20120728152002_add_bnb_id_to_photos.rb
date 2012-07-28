class AddBnbIdToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :bnb_id, :integer
  end
end

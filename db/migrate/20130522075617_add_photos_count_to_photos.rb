class AddPhotosCountToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :photos_count, :integer, default: 0
  end
end

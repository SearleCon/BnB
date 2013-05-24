class RemovePhotosCountFromPhotos < ActiveRecord::Migration
  def change
    remove_column :photos, :photos_count
  end
end

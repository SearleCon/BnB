class RemoveOrderFromPhotos < ActiveRecord::Migration
  def up
    remove_column :photos, :order
  end

  def down
  end
end

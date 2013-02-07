class ChangePhotosProcessedDefaultToFalse < ActiveRecord::Migration
  def up
    change_column :photos, :processed, :boolean, :default => false
  end

  def down
    change_column :photos, :processed, :boolean, :default => true
  end
end

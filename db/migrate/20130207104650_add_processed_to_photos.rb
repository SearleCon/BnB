class AddProcessedToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :processed, :boolean, :default => true
  end
end

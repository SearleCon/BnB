class AddMainToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :main, :boolean, default: false

  end
end

class AddPhotosCountToBnbs < ActiveRecord::Migration
  def change
    add_column :bnbs, :photos_count, :integer , default: 0
  end
end

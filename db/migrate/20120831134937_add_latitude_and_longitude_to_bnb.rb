class AddLatitudeAndLongitudeToBnb < ActiveRecord::Migration
  def change
    add_column :bnbs, :latitude, :float
    add_column :bnbs, :longitude, :float
  end
end

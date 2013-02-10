class AddRatingToBnb < ActiveRecord::Migration
  def change
    add_column :bnbs, :rating, :integer
  end
end

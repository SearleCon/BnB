class RemoveStandardRateFromBnb < ActiveRecord::Migration
  def change
    remove_column :bnbs, :standard_rate
  end
end

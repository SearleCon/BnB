class AddStandardRateToBnb < ActiveRecord::Migration
  def change
    add_column :bnbs, :standard_rate, :decimal

  end
end

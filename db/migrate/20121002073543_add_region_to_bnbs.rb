class AddRegionToBnbs < ActiveRecord::Migration
  def change
    add_column :bnbs, :region, :string

  end
end

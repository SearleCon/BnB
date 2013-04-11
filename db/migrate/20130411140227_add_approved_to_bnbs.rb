class AddApprovedToBnbs < ActiveRecord::Migration
  def change
    add_column :bnbs, :approved, :boolean, default: false
  end
end

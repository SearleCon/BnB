class RemoveColumnsFromRates < ActiveRecord::Migration
  def change
    remove_column :rates, :rate_type_id
    remove_column :rates, :per_room
    remove_column :rates, :per_person
    rename_column :rates, :name, :description
  end
end

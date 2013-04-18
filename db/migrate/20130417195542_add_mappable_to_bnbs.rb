class AddMappableToBnbs < ActiveRecord::Migration
  def change
    add_column :bnbs, :mappable, :boolean, default: false

  end
end

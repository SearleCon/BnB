class AddSlugToBnb < ActiveRecord::Migration
  def change
    add_column :bnbs, :slug, :string
    add_index :bnbs, :slug, unique: true
  end
end

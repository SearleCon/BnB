class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :country
      t.string :region
      t.string :city

      t.timestamps
    end
  end
end

class AddIndexToGuestsOnBnbId < ActiveRecord::Migration
  def change
    add_index :guests, :bnb_id
  end
end

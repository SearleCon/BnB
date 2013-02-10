class ChangeBigdecimalsToDecimals < ActiveRecord::Migration
  def up
    change_column :line_items, :value, :decimal
    change_column :rooms, :rates, :decimal
  end

  def down
  end
end

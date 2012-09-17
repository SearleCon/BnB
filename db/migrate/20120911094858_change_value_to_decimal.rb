class ChangeValueToDecimal < ActiveRecord::Migration
  def up
    change_column :line_items, :value, :BigDecimal
  end

  def down
    change_column :line_items, :value, :integer
  end
end

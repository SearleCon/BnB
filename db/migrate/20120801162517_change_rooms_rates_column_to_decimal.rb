class ChangeRoomsRatesColumnToDecimal < ActiveRecord::Migration
  def self.up
    change_table :rooms do |t|
      t.change :rates, :BigDecimal
    end
  end

  def self.down
    change_table :widgets do |t|
      t.change :rates, :float
    end
  end
end

class ChangeRoomsRatesColumnToDecimal < ActiveRecord::Migration
  def self.up
    change_table :rooms do |t|
      t.change :rates, :decimal
    end
  end

  def self.down
    change_table :rooms do |t|
      t.change :rates, :float
    end
  end
end

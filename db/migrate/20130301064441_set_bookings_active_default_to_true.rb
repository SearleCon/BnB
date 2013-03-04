class SetBookingsActiveDefaultToTrue < ActiveRecord::Migration
  def up
    change_column :bookings, :active, :boolean, :default => true
  end

  def down
    change_column :bookings, :active, :boolean, :default => false
  end

end

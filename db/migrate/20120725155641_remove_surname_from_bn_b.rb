class RemoveSurnameFromBnB < ActiveRecord::Migration
  def up
    remove_column :bnbs, :surname
  end

  def down
    add_column :bnbs, :surname, :string
  end
end

class AddCountryAndContactNumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :country, :string

    add_column :users, :contact_number, :string

  end
end

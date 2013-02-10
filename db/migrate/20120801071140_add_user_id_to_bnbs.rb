class AddUserIdToBnbs < ActiveRecord::Migration
  def change
    add_column :bnbs, :user_id, :integer
  end
end

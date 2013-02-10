class CreateBnbs < ActiveRecord::Migration
  def change
    create_table :bnbs do |t|
      t.string :name
      t.string :surname
      t.text :description
      t.string :email
      t.string :address_line_one
      t.string :address_line_two
      t.string :city
      t.string :postal_code
      t.string :country
      t.string :telephone_number
      t.string :website
      t.string :contact_person
      t.string :twitter_account
      t.string :facebook_page

      t.timestamps
    end
  end
end

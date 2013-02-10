require 'spec_helper'

describe "bnbs/othernew" do
  before(:each) do
    assign(:bnb, stub_model(Bnb,
      :name => "MyString",
      :surname => "MyString",
      :description => "MyText",
      :email => "MyString",
      :address_line_one => "MyString",
      :address_line_two => "MyString",
      :city => "MyString",
      :postal_code => "MyString",
      :country => "MyString",
      :telephone_number => "MyString",
      :website => "MyString",
      :contact_person => "MyString",
      :twitter_account => "MyString",
      :facebook_page => "MyString"
    ).as_new_record)
  end

  it "renders othernew bnb form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => bnbs_path, :method => "post" do
      assert_select "input#bnb_name", :name => "bnb[name]"
      assert_select "input#bnb_surname", :name => "bnb[surname]"
      assert_select "textarea#bnb_description", :name => "bnb[description]"
      assert_select "input#bnb_email", :name => "bnb[email]"
      assert_select "input#bnb_address_line_one", :name => "bnb[address_line_one]"
      assert_select "input#bnb_address_line_two", :name => "bnb[address_line_two]"
      assert_select "input#bnb_city", :name => "bnb[city]"
      assert_select "input#bnb_postal_code", :name => "bnb[postal_code]"
      assert_select "input#bnb_country", :name => "bnb[country]"
      assert_select "input#bnb_telephone_number", :name => "bnb[telephone_number]"
      assert_select "input#bnb_website", :name => "bnb[website]"
      assert_select "input#bnb_contact_person", :name => "bnb[contact_person]"
      assert_select "input#bnb_twitter_account", :name => "bnb[twitter_account]"
      assert_select "input#bnb_facebook_page", :name => "bnb[facebook_page]"
    end
  end
end

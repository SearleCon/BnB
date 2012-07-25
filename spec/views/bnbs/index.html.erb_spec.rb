require 'spec_helper'

describe "bnbs/index" do
  before(:each) do
    assign(:bnbs, [
      stub_model(Bnb,
        :name => "Name",
        :surname => "Surname",
        :description => "MyText",
        :email => "Email",
        :address_line_one => "Address Line One",
        :address_line_two => "Address Line Two",
        :city => "City",
        :postal_code => "Postal Code",
        :country => "Country",
        :telephone_number => "Telephone Number",
        :website => "Website",
        :contact_person => "Contact Person",
        :twitter_account => "Twitter Account",
        :facebook_page => "Facebook Page"
      ),
      stub_model(Bnb,
        :name => "Name",
        :surname => "Surname",
        :description => "MyText",
        :email => "Email",
        :address_line_one => "Address Line One",
        :address_line_two => "Address Line Two",
        :city => "City",
        :postal_code => "Postal Code",
        :country => "Country",
        :telephone_number => "Telephone Number",
        :website => "Website",
        :contact_person => "Contact Person",
        :twitter_account => "Twitter Account",
        :facebook_page => "Facebook Page"
      )
    ])
  end

  it "renders a list of bnbs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Surname".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Address Line One".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Address Line Two".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "City".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Postal Code".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Country".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Telephone Number".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Website".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Contact Person".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Twitter Account".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Facebook Page".to_s, :count => 2
  end
end

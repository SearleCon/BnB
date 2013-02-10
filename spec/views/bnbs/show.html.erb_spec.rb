require 'spec_helper'

describe "bnbs/show" do
  before(:each) do
    @bnb = assign(:bnb, stub_model(Bnb,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Surname/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Email/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Address Line One/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Address Line Two/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/City/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Postal Code/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Country/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Telephone Number/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Website/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Contact Person/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Twitter Account/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Facebook Page/)
  end
end

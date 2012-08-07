require 'spec_helper'

describe "guests/edit" do
  before(:each) do
    @guest = assign(:guest, stub_model(Guest,
      :name => "MyString",
      :surname => "MyString",
      :contact_number => "MyString"
    ))
  end

  it "renders the edit guest form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => guests_path(@guest), :method => "post" do
      assert_select "input#guest_name", :name => "guest[name]"
      assert_select "input#guest_surname", :name => "guest[surname]"
      assert_select "input#guest_contact_number", :name => "guest[contact_number]"
    end
  end
end

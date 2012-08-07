require 'spec_helper'

describe "guests/new" do
  before(:each) do
    assign(:guest, stub_model(Guest,
      :name => "MyString",
      :surname => "MyString",
      :contact_number => "MyString"
    ).as_new_record)
  end

  it "renders new guest form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => guests_path, :method => "post" do
      assert_select "input#guest_name", :name => "guest[name]"
      assert_select "input#guest_surname", :name => "guest[surname]"
      assert_select "input#guest_contact_number", :name => "guest[contact_number]"
    end
  end
end

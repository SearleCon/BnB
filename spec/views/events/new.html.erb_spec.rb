require 'spec_helper'

describe "events/othernew" do
  before(:each) do
    assign(:event, stub_model(Event,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders othernew event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => events_path, :method => "post" do
      assert_select "input#event_name", :name => "event[name]"
    end
  end
end

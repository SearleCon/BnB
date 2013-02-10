require 'spec_helper'

describe "rooms/othernew" do
  before(:each) do
    assign(:room, stub_model(Room).as_new_record)
  end

  it "renders othernew room form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => rooms_path, :method => "post" do
    end
  end
end

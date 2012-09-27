require 'spec_helper'

describe "bookings/othernew" do
  before(:each) do
    assign(:booking, stub_model(Booking,
      :guest_id => 1,
      :room_id => 1,
      :active => false
    ).as_new_record)
  end

  it "renders othernew booking form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => bookings_path, :method => "post" do
      assert_select "input#booking_guest_id", :name => "booking[guest_id]"
      assert_select "input#booking_room_id", :name => "booking[room_id]"
      assert_select "input#booking_active", :name => "booking[active]"
    end
  end
end

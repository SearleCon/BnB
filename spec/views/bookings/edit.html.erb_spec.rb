require 'spec_helper'

describe "bookings/edit" do
  before(:each) do
    @booking = assign(:booking, stub_model(Booking,
      :guest_id => 1,
      :room_id => 1,
      :active => false
    ))
  end

  it "renders the edit booking form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => bookings_path(@booking), :method => "post" do
      assert_select "input#booking_guest_id", :name => "booking[guest_id]"
      assert_select "input#booking_room_id", :name => "booking[room_id]"
      assert_select "input#booking_active", :name => "booking[active]"
    end
  end
end

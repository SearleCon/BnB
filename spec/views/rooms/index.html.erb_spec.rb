require 'spec_helper'

describe "rooms/index" do
  before(:each) do
    assign(:rooms, [
      stub_model(Room),
      stub_model(Room)
    ])
  end

  it "renders a list of rooms" do
    render
  end
end

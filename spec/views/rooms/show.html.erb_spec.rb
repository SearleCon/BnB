require 'spec_helper'

describe "rooms/show" do
  before(:each) do
    @room = assign(:room, stub_model(Room))
  end

  it "renders attributes in <p>" do
    render
  end
end

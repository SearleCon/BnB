require 'spec_helper'

describe "Guests" do
  describe "GET /guests" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get guests_path
      response.status.should be(200)
    end
  end
end

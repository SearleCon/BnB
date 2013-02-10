require 'spec_helper'

describe ContactController do

  describe "GET 'othernew'" do
    it "returns http success" do
      get 'othernew'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

end

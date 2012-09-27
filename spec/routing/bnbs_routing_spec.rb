require "spec_helper"

describe BnbsController do
  describe "routing" do

    it "routes to #index" do
      get("/bnbs").should route_to("bnbs#index")
    end

    it "routes to #othernew" do
      get("/bnbs/othernew").should route_to("bnbs#new")
    end

    it "routes to #show" do
      get("/bnbs/1").should route_to("bnbs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/bnbs/1/edit").should route_to("bnbs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/bnbs").should route_to("bnbs#create")
    end

    it "routes to #update" do
      put("/bnbs/1").should route_to("bnbs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/bnbs/1").should route_to("bnbs#destroy", :id => "1")
    end

  end
end

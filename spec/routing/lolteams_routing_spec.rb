require "rails_helper"

RSpec.describe LolteamsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/lolteams").to route_to("lolteams#index")
    end

    it "routes to #new" do
      expect(:get => "/lolteams/new").to route_to("lolteams#new")
    end

    it "routes to #show" do
      expect(:get => "/lolteams/1").to route_to("lolteams#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/lolteams/1/edit").to route_to("lolteams#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/lolteams").to route_to("lolteams#create")
    end

    it "routes to #update" do
      expect(:put => "/lolteams/1").to route_to("lolteams#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/lolteams/1").to route_to("lolteams#destroy", :id => "1")
    end

  end
end

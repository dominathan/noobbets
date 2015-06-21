require 'rails_helper'

RSpec.describe SummonersController, type: :controller do

    context 'when signed in' do
      let(:summoner) { FactoryGirl.create(:summoner) }
      before :each do
        login_with create(:user)
      end

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "returns http success" do
      get :show, { id: summoner.id }
      expect(response).to have_http_status(:success)
    end
  end

end

require 'rails_helper'

RSpec.describe BetsController, type: :controller do

  context "anonymous user" do
    before :each do
      # This simulates an anonymous user
      login_with nil
    end

    it "should be redirected to signin on the index" do
      get :index
      expect( response ).to redirect_to( new_user_session_path )
    end

    it "should be redirected to signin on the my_noobbets" do
      get :my_noobbets
      expect(response).to have_http_status(:redirect)
      expect( response ).to redirect_to( new_user_session_path )
    end

    it "should be redirected to signin on the my_won_noobbets" do
      get :my_won_noobbets
      expect(response).to have_http_status(:redirect)
      expect( response ).to redirect_to( new_user_session_path )
    end
  end

  context 'when logged in' do
    let(:bet) { FactoryGirl.create(:bet) }
    let(:lolteam) {FactoryGirl.create(:lolteam) }
    before :each do
      login_with create(:user)
    end

    it "should let a user see all open noobbets" do
      get :index
      expect( response ).to render_template( :index )
    end

    it 'should let a user see his/her active noobbets' do
      get :my_active_noobbets
      expect( response ).to render_template(:my_active_noobbets)
    end

    it 'should let a user see individual noobbets' do
      get :show_noobbet, { bet_id: bet.id, id: lolteam.id }
      expect(response).to render_template(:show_noobbet)
      expect(assigns(:bet)).to eq(bet)
    end
  end
end

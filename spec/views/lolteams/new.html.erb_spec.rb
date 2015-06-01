require 'rails_helper'

RSpec.describe "lolteams/new", type: :view do
  before(:each) do
    assign(:lolteam, Lolteam.new(
      :user => nil,
      :bet => nil,
      :slot1 => 1,
      :slot2 => 1,
      :slot3 => 1,
      :slot4 => 1,
      :slot5 => 1,
      :slot6 => 1,
      :slot7 => 1
    ))
  end

  it "renders new lolteam form" do
    render

    assert_select "form[action=?][method=?]", lolteams_path, "post" do

      assert_select "input#lolteam_user_id[name=?]", "lolteam[user_id]"

      assert_select "input#lolteam_bet_id[name=?]", "lolteam[bet_id]"

      assert_select "input#lolteam_slot1[name=?]", "lolteam[slot1]"

      assert_select "input#lolteam_slot2[name=?]", "lolteam[slot2]"

      assert_select "input#lolteam_slot3[name=?]", "lolteam[slot3]"

      assert_select "input#lolteam_slot4[name=?]", "lolteam[slot4]"

      assert_select "input#lolteam_slot5[name=?]", "lolteam[slot5]"

      assert_select "input#lolteam_slot6[name=?]", "lolteam[slot6]"

      assert_select "input#lolteam_slot7[name=?]", "lolteam[slot7]"
    end
  end
end

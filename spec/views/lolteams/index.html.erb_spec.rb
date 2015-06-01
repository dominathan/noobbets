require 'rails_helper'

RSpec.describe "lolteams/index", type: :view do
  before(:each) do
    assign(:lolteams, [
      Lolteam.create!(
        :user => nil,
        :bet => nil,
        :slot1 => 1,
        :slot2 => 2,
        :slot3 => 3,
        :slot4 => 4,
        :slot5 => 5,
        :slot6 => 6,
        :slot7 => 7
      ),
      Lolteam.create!(
        :user => nil,
        :bet => nil,
        :slot1 => 1,
        :slot2 => 2,
        :slot3 => 3,
        :slot4 => 4,
        :slot5 => 5,
        :slot6 => 6,
        :slot7 => 7
      )
    ])
  end

  it "renders a list of lolteams" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
  end
end

require 'rails_helper'

RSpec.describe "lolteams/show", type: :view do
  before(:each) do
    @lolteam = assign(:lolteam, Lolteam.create!(
      :user => nil,
      :bet => nil,
      :slot1 => 1,
      :slot2 => 2,
      :slot3 => 3,
      :slot4 => 4,
      :slot5 => 5,
      :slot6 => 6,
      :slot7 => 7
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/6/)
    expect(rendered).to match(/7/)
  end
end

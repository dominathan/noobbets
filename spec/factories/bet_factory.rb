FactoryGirl.define do

  factory :bet, class: "Bet" do
    start_time       DateTime.now
    end_time         DateTime.now + 1.day
    entrants         10
    user_count       0
    cost             1000
    bet_type         "winner_take_all"
    completed         false
  end
end
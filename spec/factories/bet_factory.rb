FactoryGirl.define do

  factory :bet, class: "Bet" do
    start_time       DateTime.now + 1.day
    end_time         DateTime.now + 2.days
    entrants         10
    cost             1000
    bet_type         "Winner Take All"
    completed         false
    reward           9000
  end
end

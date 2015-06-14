FactoryGirl.define do
  factory :game, class: "Game" do
    champions_killed         1
    assists                  1
    minions_killed           1
    num_deaths               1
    win                      true
    triple_kills             1
    quadra_kills             1
    penta_kills              1
    first_blood              1
    lol_game_id              1
    create_date              DateTime.now
    total_score              1
    summoner
  end
end

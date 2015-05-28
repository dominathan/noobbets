FactoryGirl.define do

  sequence :lol_id do |n|
    n
  end

  factory :summoner, class: "Summoner" do
    name      "Jogadas"
    lol_id
  end
end


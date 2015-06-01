FactoryGirl.define do

  sequence :lol_id do |n|
    n
  end

  sequence :name do |n|
    "RandomName#{n}"
  end

  factory :summoner, class: "Summoner" do
    name
    lol_id
  end
end


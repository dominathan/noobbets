class Summoner < ActiveRecord::Base
  has_many :games

  def self.create_summoner(obj)
    if Summoner.find_by(lol_id: obj.first.last['id'].to_i) == nil
      Summoner.create(lol_id: obj.first.last["id"].to_i, name: obj.first.last['name'])
    end
  end

  def self.create_them_all(json_object)
    json_object.each do |person|
      Summoner.create_summoner(person)
    end
  end
end

require 'open-uri'
require 'json'
require 'nokogiri'

module TopPlayers
  class Tops
    attr_accessor

    def self.get_top_players(num)
      players = []
      1.upto(num) do |i|
        website = "http://www.lolskill.net/top/highest-lolskillscore/page-#{i}?filterChampion=&filterRealm=NA"
        page  = Nokogiri::HTML(open(website))
        page.css('.summoner').each { |link| players << link.text }
      end
      players.uniq - ["[Unknown Name]"]
    end

  end
end

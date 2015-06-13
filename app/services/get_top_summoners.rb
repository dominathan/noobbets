require 'open-uri'
require 'json'
require 'nokogiri'

class GetTopSummoners
  attr_reader

  def self.get_from_lolking(number_of_pages)
    players = []
    1.upto(number_of_pages) do |i|
      website = "http://www.lolskill.net/top/highest-lolskillscore/page-#{i}?filterChampion=&filterRealm=NA"
      page  = Nokogiri::HTML(open(website))
      page.css('.summoner').each { |link| players << link.text }
    end
    players.uniq - ["[Unknown Name]"]
  end

end

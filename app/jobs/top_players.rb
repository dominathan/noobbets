require 'open-uri'
require 'json'

module TopPlayers
  class Tops
    attr_accessor :list

    def initialize
      players1 = ["Sunohara", "grazer", "grazer", "Weixiao", "grazer", "grazer", "[Unknown Name]", "grazer", "grazer", "A Wild AP Sona", "Door Meat", "grazer", "Mourning Light", "WldSonaIsNo1Sona", "grazer", "grazer", "Scooter Sparkle", "Scooter Sparkle", "Drixenol", "grazer", "grazer", "Zaineking", "Annie Bot", "FTW", "Hunger x Hunger", "Blown by Janna", "S Diana 2", "Guardian Janna", "Freeze", "Fuszion"]
      players2 = ["VelKozby", "Summer Sparkle", "Simple Smiles", "Buckaroo", "Ivan Pavlov", "Alterhaze", "grazer", "iRakin", "Fate Twisted", "Yekim", "Diamond 1 Khazix", "Doctor Sleak", "DTN nororin", "Guardian Janna", "Garoth Ursuul", "ChaosRain77", "Waesuri", "BastilleA", "Lesudesu", "CrushDavide", "grazer", "st1tch", "Herald 0f Death", "Kaichu", "FairieTail", "Summer Sparkle", "King of Memes", "O Y A B O N G", "juKi", "Zoar"]
      players3 = ["kT69Xo", "PAlNLESS", "Arch Angeloid", "Slamx", "Mourning Light", "rengar ty", "Kitzuo", "silvermidget", "DeT FM Yumenoti", "Mr Gimix", "ZEN Virus", "Puleo", "BorisGump", "Minishcap1", "Best Ezreal KR", "Shorthop", "twitchtvz4mk4", "BardlotTKO", "Scrumm", "Emanpop", "Jackoo", "Penquynh", "Old Thing Back", "Akaadian", "Reservation", "BmxSpecks", "hai you shei", "Beasted", "moonway", "fnatk"]
      players4 = ["Kaili", "iMadeThisForJodi", "Noobataur", "NME Trashyy", "BonQuish", "Orage", "ArchangelEZ", "DadeFakerPawn", "C9 Meteos", "bigsuga", "Katar", "Emanpop", "Irelia Carries U", "Susice", "Lee Hyun", "NCS Father GuDu", "anham", "Sepeku AW", "QBSRD0L", "Aceirl", "BJNA", "KiNG Nidhogg", "Ritchiee", "Sjyir", "BonQuish", "Sleepyz", "Karvinen", "Kazahana", "Neat", "Janna Mechanics"]
      players5 = ["DeT FM Yumenoti", "eryf", "Lionsexual", "davidroo", "ETS Veelox", "30DayChallenge", "Prototype Blade", "Tangularx", "Hellkey", "Im Novel", "HeroRAMBO", "Sleepyz", "deribou", "Baesed", "Canadian Janna", "0uchie", "Biofrost", "Eoba", "BoxerPete", "Kurisuchan", "lolcatz420", "AnnieTopOnly", "Hawk", "JimmyX", "Stormcleave", "Spiner909", "MvProv", "Silencee", "jbraggs", "toontown"]
      players6 = ["GladeGleamBright", "thegreens", "dOdObee", "iMadeThisForJodi", "Zyphere", "Liquid Warlock", "King Cobra", "Thalies", "Ricky Tang", "Emanpop", "BillysBoss", "BastilleA", "Lost Blademan", "Agent Wan", "jacksparrow111", "HPoP", "NctrI", "AxalaraT9", "PAlNLESS", "Rakin is Bae", "FTW", "Visvìm", "BG Jessica Jung", "SSBM Hax", "Pseudo Intellect", "fuk poony cheeps", "Best Ezreal KR", "TG Cal", "fabbbyyy", "Niqhtmare a"]
      @list = players1 + players2 + players3 + players4 + players5 + players6
    end

  end
end

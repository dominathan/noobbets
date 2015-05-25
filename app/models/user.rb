class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

 #Add Pepper for bigger encryption?

 # has_many :bets, through: :bets_users
 # has_many :bets_users

# LCS Players are scored accordingly:

  # 2 points per kill
  # -0.5 points per death
  # 1.5 points per assist
  # 0.01 points per creep kill
  # 2 points for a triple kill
  # 5 points for a quadra kill (doesn't also count as a triple kill)
  # 10 points for a penta kill (doesn't also count as a quadra kill)
  # 2 points if a player attains 10 or more assists or kills in a game (this bonus only applies once)
  # 3 points for first blood
  # LCS Teams are scored accordingly:

  # 2 points per win
  # 2 points per Baron Nashor killed
  # 1 point per Dragon killed
  # 2 points per First Blood earned
  # 1 point per Tower destroyed
  # 2 points if the team wins in less than 30 minutes
  # Match results and points are updated live. Follow along on the match-ups page.


end

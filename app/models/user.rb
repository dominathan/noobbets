class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
          #Add Pepper for bigger encryption?

  has_many :bets, through: :bet_users
  has_many :bet_users

  has_many :lolteams

  validates_presence_of :username
  validates_uniqueness_of :username

  after_create :give_fake_money


  private

    def give_fake_money
      self.update_attribute(:fake_money, 40000)
    end

end

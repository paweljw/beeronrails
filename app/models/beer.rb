class Beer < ActiveRecord::Base
  attr_accessible :browar, :foto, :komentarz, :kraj, :nazwa

  validates :nazwa, presence: true
  validates :browar, presence: true
  validates :kraj, presence: true
end

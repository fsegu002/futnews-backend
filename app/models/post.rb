class Post < ApplicationRecord
  belongs_to :match
  belongs_to :team
  belongs_to :player
  belongs_to :play_type
  belongs_to :user
  has_many :likes

  validates :play_type, :team, :player, :minute, :match, presence: true
end

class Match < ApplicationRecord
    has_many :posts
    validates :match_day, :home_team, :away_team, :match_id, presence: true
end

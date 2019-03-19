class Match < ApplicationRecord
    has_many :posts
    belongs_to :league
    validates :match_day, :home_team, :away_team, :match_id, presence: true
end

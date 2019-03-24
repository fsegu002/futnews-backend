class Post < ApplicationRecord
  belongs_to :match
  belongs_to :team
  belongs_to :player
  belongs_to :play_type
  belongs_to :user
  has_many :likes

  validates :play_type, :team, :player, :minute, :match, presence: true

  def self.build_post_with_likes(p)
    newPost = {
      id: p.id,
      minute: p.minute,
      play_type_code: p.play_type_code,
      play_type_name: p.play_type_name,
      player_name: p.player_name,
      player_number: p.player_number,
      team_id: p.team_id,
      number_of_likes: p.likes.length
    }
  end
end

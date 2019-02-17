class Player < ApplicationRecord
  belongs_to :team
  has_many :posts

  validates :name, :position, :shirt_number, presence:  true
end

class PlayType < ApplicationRecord
    has_many :posts

    validates :code, :name, presence: true
end

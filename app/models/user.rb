class User < ApplicationRecord
    has_many :posts
    has_secure_password
    validates :password, presence: { on: :create}, length: {minimum: 8, allow_blank:  true }
end

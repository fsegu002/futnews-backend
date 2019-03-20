class User < ApplicationRecord
    has_many :posts
    has_many :likes
    
    has_secure_password
    validates :password, presence: { on: :create}, length: {minimum: 8, allow_blank:  true }
    validates :email, uniqueness: true

    def password_match?
       self.password == self.password_confirmation
    end

    def is_confirmed?
        self.confirmed
    end

end

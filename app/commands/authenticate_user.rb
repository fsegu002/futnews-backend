class AuthenticateUser
    prepend SimpleCommand
  
    def initialize(params)
        @email = params[:email]
        @password = params[:password]
    end
  
    def call
        token = JsonWebToken.encode(user_id: user.id) if user
        
        return {token: token, user: user.attributes.except("password_digest")} unless user == nil
    end
  
    private
  
        attr_accessor :email, :password
    
        def user
            user = User.find_by_email(email)
            return nil if user.blank?
            return user if user && user.authenticate(password)
        
            errors.add :user_authentication, {message: "Invalid credentials", code: "invalid"}
            nil
        end
end
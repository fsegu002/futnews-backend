module Api
  module V1
    class V1::UsersController < ApplicationController
      skip_before_action :authenticate_request, only: :create

      def create
        # if params[:password] != params[:password_confirmation] 
        #   render json: {message: "Password doesn't match"}, status: :internal_server_error
        # end

        @user = User.new(user_params)
        if @user.save && @user.password_match?
          render json: @user, status: :created
        else
          render json: {message: @user.errors}, status: :internal_server_error
        end
      end

      private
        def user_params
          params.permit(:email, :password, :password_confirmation)
        end
    end    
  end
end

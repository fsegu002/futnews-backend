module Api
  module V1
    class V1::UsersController < ApplicationController
      skip_before_action :authenticate_request, only: :create
      before_action :set_user, only: [:confirm_user]

      def create
        @user = User.new(user_params)

        if @user.password_match? 
          if @user.save
            UserMailer.signup_confirmation(@user).deliver
            # render json: @user.attributes.except("password_digest"), status: :created
            command = AuthenticateUser.call(user_params)

            if command.success?
                if command.result.present?
                    render json: command.result
                else
                    render json: { message: 'User email was not found' }, status: :unauthorized
                end
            else
                render json: { error: command.errors }, status: :unauthorized
            end
          else
            render json: {message: @user.errors}, status: :bad_request
          end
        else
          render json: {message: "Passwords don't match"}, status: :bad_request
        end
      end

      def confirm_user
        return false if @user.is_confirmed?
        if @user.update(confirmed: true)
          render json: {message: "#{@user.email} has been confirmed."}, status: :ok
        else
          render json: {message: @user.errors}, status: :bad_request
        end
      end

      private
        def set_user
          @user = User.find(params[:id])
        end

        def user_params
          params.permit(:email, :password, :password_confirmation)
        end


    end    
  end
end

module Api
  module V1
    class V1::UsersController < ApplicationController
      skip_before_action :authenticate_request, only: :create
      before_action :set_user, only: [:confirm_user]

      def create
        @user = User.new(user_params)
        if @user.save && @user.password_match?
          UserMailer.signup_confirmation(@user).deliver
          render json: @user, status: :created
        else
          render json: {message: @user.errors}, status: :internal_server_error
        end
      end

      def confirm_user
        return false if @user.is_confirmed?
        if @user.update(confirmed: true)
          render json: {message: "#{@user.email} has been confirmed."}, status: :ok
        else
          render json: {message: @user.errors}, status: :internal_server_error
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

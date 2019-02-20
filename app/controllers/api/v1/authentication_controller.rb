module Api
    module V1
        class AuthenticationController < ApplicationController
            skip_before_action :authenticate_request
           
            def authenticate
                command = AuthenticateUser.call(params[:email], params[:password])

                if command.success?
                    if command.result.present?
                        render json: command.result
                    else
                        render json: { message: 'User email was not found' }, status: :unauthorized
                    end
                else
                    render json: { error: command.errors }, status: :unauthorized
                end
            end
        end
    end
end
module Api
  module V1
    class V1::PlayTypesController < ApplicationController
      def index
        @play_type = PlayType.select(:id, :code, :name)
        render json: @play_type, status: :ok
      end

      def create
        @play_type = PlayType.new(type_params)
        if @play_type.save
          render json: @play_type, status: :created
        else
          render json: {message: "an error occurred, record was not saved"}, status: :internal_server_error
        end
      end

      def update
        @play_type = PlayType.find(params[:id])
        
        if @play_type.update(type_params)
          render json: @play_type, status: :ok
        else
          render json: {message: "an error occurred, record was not updated"}, status: :internal_server_error
        end
      end

      def delete
        @play_type = PlayType.find(params[:id])
        if @play_type.destroy
          render status: :no_content
        else
          render json: {message: "an error occurred, record was not deleted"}, status: :internal_server_error
        end
      end

      private
        def type_params
          params.permit(:code, :name)
        end
    end
  end
end

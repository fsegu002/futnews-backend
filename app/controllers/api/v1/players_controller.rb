module Api
    module V1
        class V1::PlayersController < ApplicationController
            def getTeamPlayers
                @players = Player.where(team_id: params[:team_id])
                if @players.length > 0
                    response = { length: @players.length, data: @players }
                    render json: response, status: :ok
                else
                    render json: {message: "Team doesn't exist"}.to_json, status: :not_found
                end
            end
        end
    end
end

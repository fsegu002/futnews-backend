require 'rest-client'
require 'json'

class Football
    attr_reader  :url, :api_version, :api_token, :full_url
    def initialize
        @url = 'http://api.football-data.org'
        @api_version = '/v2'
        @api_token = ENV['FOOTBALL_ORG_API_TOKEN']
        @full_url = @url + @api_version
    end

    def get_matches 
        begin
            results = RestClient.get(full_url+"/competitions/2021/matches", headers={
                'X-Auth-Token' => api_token
            })             
        rescue RestClient::ExceptionWithResponse => e
            e.response
        end
    end
    def get_team(team_id)
        begin
            results = RestClient.get(full_url+"/teams/#{team_id}", headers={
                'X-Auth-Token' => api_token
            })
        rescue RestClient::ExceptionWithResponse => e
            e.response
        end
    end


    def get_teams
        begin
            results = RestClient.get(full_url+"/competitions/2021/teams", headers={
                'X-Auth-Token' => api_token
            })
        rescue RestClient::ExceptionWithResponse => e
            e.response
        end
    end

end    
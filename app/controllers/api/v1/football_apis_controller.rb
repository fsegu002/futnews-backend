module Api
    module V1
        class V1::FootballApisController < ApplicationController
            before_action :set_league, only: [:fetch_and_save_matches, :fetch_and_update_matches]

            def fetch_and_save_teams 
                results = football_api
                allTeams = JSON.parse(results.get_teams)
                allTeams["teams"].each do |key, value|
                    Team.create(
                        name: key["name"], 
                        team_id: key["id"], 
                        crest_url: key["crestUrl"],
                        short_name: key["shortName"], 
                        info: key
                        )
                end
            end

            def fetch_and_update_teams 
                results = football_api
                allTeams = JSON.parse(results.get_teams)
                allTeams["teams"].each do |key, value|
                    team = Team.find_by(team_id: key["id"])
                    team.update(
                        name: key["name"],
                        short_name: key["shortName"],
                        crest_url: key["crestUrl"],
                        info: key
                    )
                end
            end

            def fetch_and_save_players
                teams = Team.all
                results = football_api

                teams.each do |t|
                    team_with_players = JSON.parse(results.get_team(t["team_id"]))
                    
                    team_with_players["squad"].each do |p|
                        player = t.players.build(
                            name: p["name"],
                            position: p["position"],
                            date_of_birth: p["dateOfBirth"],
                            country_of_birth: p["countryOfBirth"],
                            nationality: p["nationality"],
                            shirt_number: p["shirtNumber"]
                        )
                        player.save
                    end
                    # The free API only allows 10 calls perminute
                    # Make the call for each team every 6.5 seconds so it doesn't exceed the limit
                    sleep 6.5
                end
            end

            def fetch_and_save_matches
                matchesArr = []
                results = football_api
                allMatches = JSON.parse(results.get_matches)
                allMatches["matches"].each do |m|
                    matchesArr.push(build_match(m))
                end
                Match.create(matchesArr)
            end

            def fetch_and_update_matches
                results = football_api
                updatedMatches = JSON.parse(results.get_matches)
                updatedMatches["matches"].each do |m|
                    savedMatch = Match.where("match_id = #{m["id"]}")
                    savedMatch.update(build_match(m))
                end
            end

            private
                def football_api
                    results = Football.new()
                end

                def build_match(match_info)
                    match = {
                        match_id: match_info["id"],
                        match_day: match_info["matchday"],
                        utc_date: match_info["utcDate"],
                        home_team: match_info["homeTeam"]["id"],
                        away_team: match_info["awayTeam"]["id"],
                        status: match_info["status"],
                        info: match_info,
                        league_id: @league[:id].to_i
                    }
                end

                def set_league
                    # Premier League
                    league_selection = League.all.where(code: "PL").limit(1)
                    @league = league_selection[0]
                end
        end
    end
end


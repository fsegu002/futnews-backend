module Api
    module V1        
        class Api::V1::MatchesController < ApplicationController
            def index
                begin
                    selected_date = Date.parse(params[:date_selected])
                rescue => e 
                    puts "Error: #{e}"
                    return render json: {code: "error", message: e}, status: :bad_request
                end
                matches = Match.select(:id, :utc_date, :info, 
                                        "ta.id as team_id", 
                                        "ta.short_name as home", 
                                        "tb.id as team_id", 
                                        "tb.short_name as away", 
                                        "ta.crest_url as home_logo", 
                                        "tb.crest_url as away_logo",
                                        "l.title as league_title")
                                .joins("LEFT JOIN teams as ta ON ta.team_id = home_team")
                                .joins("LEFT JOIN teams as tb ON tb.team_id = away_team")
                                .joins("LEFT JOIN leagues as l ON l.id = league_id")
                                .where(utc_date: selected_date.beginning_of_day..selected_date.end_of_day)
                                .order(:utc_date)
                results = []
                matches.each do |m|
                    results.push(build_match_info(m, m.posts.count))
                end
                render json: results
            end

            def show
                match = Match.select(   :id, :utc_date, :info, 
                                        "ta.id as home_team_id", 
                                        "ta.short_name as home", 
                                        "tb.id as away_team_id", 
                                        "tb.short_name as away", 
                                        "ta.crest_url as home_logo", 
                                        "tb.crest_url as away_logo",
                                        "l.title as league_title")
                                    .joins("LEFT JOIN teams as ta ON ta.team_id = home_team")
                                    .joins("LEFT JOIN teams as tb ON tb.team_id = away_team")
                                    .joins("LEFT JOIN leagues as l ON l.id = league_id")
                                    .where(id: params[:id])
                                    .limit(1)
                                    
                posts = Post.select(:id, :minute, :team_id, 
                                    "pt.name as play_type_name", 
                                    "pt.code as play_type_code", 
                                    "p.name as player_name", 
                                    "p.shirt_number as player_number")
                            .joins("LEFT JOIN play_types as pt ON pt.id = play_type_id")
                            .joins("LEFT JOIN players as p ON p.id = player_id")
                            .where(match_id: params[:id]).order(minute: :desc)
                
                postsArr = []
                posts.map do |p| 
                    post = Post.build_post_with_likes(p)
                    post["user_likes_post"] = Like.user_liked_post(p.id, @current_user.id)
                    postsArr << post
                end

                response = {
                    match: build_match_info(match[0], posts.length),
                    posts: postsArr
                }
                render json: response, status: :ok
            end

            def showMatchOnly
                match = Match.select(:id, :utc_date, :info, 
                                "ta.id as home_team_id", 
                                "ta.short_name as home", 
                                "tb.id as away_team_id", 
                                "tb.short_name as away", 
                                "ta.crest_url as home_logo", 
                                "tb.crest_url as away_logo",
                                "l.title as league_title")
                                .joins("LEFT JOIN teams as ta ON ta.team_id = home_team")
                                .joins("LEFT JOIN teams as tb ON tb.team_id = away_team")
                                .joins("LEFT JOIN leagues as l ON l.id = league_id")
                                .where(id: params[:id])
                                .limit(1)

                render json: build_match_info(match[0], match.posts.count), status: :ok
            end


            private
                def build_match_info(match, post_count = nil)
                    match_info = {
                        id: match["id"],
                        utc_date: match["utc_date"],
                        info: match["info"],
                        post_count: post_count,
                        league_title: match["league_title"],
                        teams: [{
                            id: match["home_team_id"],
                            team_type: 'home-team',
                            name: match["info"]["homeTeam"]["name"],
                            short_name: match["home"],
                            logo_url: match["home_logo"],
                            score: match["info"]["score"]["fullTime"]["homeTeam"]
                        },{
                            id: match["away_team_id"],
                            team_type: 'away-team',
                            name: match["info"]["awayTeam"]["name"],
                            short_name: match["away"],
                            logo_url: match["away_logo"],
                            score: match["info"]["score"]["fullTime"]["awayTeam"]
                        }]
                    }
                end
        end
    end

end

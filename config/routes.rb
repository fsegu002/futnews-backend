Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'play_types/new'
  get 'play_types/edit'
  get 'play_types/delete'
  namespace :api do
    namespace :v1 do
      post '/users/create' 
      post '/users/:id/confirm_user', to: 'users#confirm_user'

      post '/posts', to: 'posts#create'

      post '/authenticate', to: 'authentication#authenticate'

      get '/play_type', to: 'play_types#index'
      post '/play_type', to: 'play_types#create'
      put '/play_type/:id', to: 'play_types#update'
      delete '/play_type/:id', to: 'play_types#delete'
      
      get '/matches/:id/newMatch', to: 'matches#showMatchOnly'
      get '/matches', to: 'matches#index'
      get '/matches/:id', to: 'matches#show'


      get '/players/:team_id', to: 'players#getTeamPlayers'

      get '/fetch_and_save_teams', to: 'football_apis#fetch_and_save_teams'
      get '/fetch_and_update_teams', to: 'football_apis#fetch_and_update_teams'
      get '/fetch_and_save_players', to: 'football_apis#fetch_and_save_players'
      get '/fetch_and_save_matches', to: 'football_apis#fetch_and_save_matches'
      get '/fetch_and_update_matches', to: 'football_apis#fetch_and_update_matches'
    end
  end

end

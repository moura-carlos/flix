
Rails.application.routes.draw do
  resources :reviews
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "movies#index"
=begin
  get '/movies' => 'movies#index'

  get 'movies/new' => 'movies#new', as: 'new_movie'
  get '/movies/:id' => 'movies#show', as: "movie"

  get '/movies/:id/edit' => 'movies#edit', as: "edit_movie"
  patch '/movies/:id' => 'movies#update'

  post '/movies' => 'movies#create', as: 'create_movie'
=end
  resources :movies do
    resources :reviews
  end

  # Route to:
  # Display reviews for a given movie:
  # movies/:movie_id/reviews -> reviews#index
  # Allow users to write reviews
  # movies/:movie_id/reviews/new
  #
end

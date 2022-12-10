
Rails.application.routes.draw do
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
  resources :movies
end

Rottenpotatoes::Application.routes.draw do
match 'find_similar_movies/:id' => 'movies#find_similar_movies',
  via: :get, as: :find_similar_movies

  resources :movies 

  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
end

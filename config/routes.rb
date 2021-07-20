Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root :to => redirect('/decks')

  post "/upload", to: "decks#upload"
  get '/download', to: "decks#download"

  resources :decks do
  end
end

Rails.application.routes.draw do

root to: "pokedex#home"
get "/pokedex", to: "pokedex#index", as: :index
get "/pokedex/:id", to: "pokedex#show", as: :show

end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  controller :application do
    get '/game' => :game
    post '/validate' => :validate
  end
end

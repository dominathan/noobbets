Rails.application.routes.draw do


  root 'homes#index'

  devise_for :users

  get '/my_noobbets', to: "bets#my_noobbets"
  resources :bets do
    resources :lolteams
  end


end

Rails.application.routes.draw do




  root 'homes#index'

  devise_for :users

  get '/my_noobbets', to: "bets#my_noobbets"
  get '/my_noobbet/:id', to: "bets#show_noobbet", as: "my_noobbet"
  resources :bets do
    resources :lolteams
  end

  resources :summoners, only: [:index, :show]


end

Rails.application.routes.draw do

  devise_for :users

  resources :bets
  root 'homes#index'

end

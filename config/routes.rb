Rails.application.routes.draw do

  root 'homes#index'

  devise_for :users

  resources :bets do
  end


end

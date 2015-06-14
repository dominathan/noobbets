require 'sidekiq/web'
Rails.application.routes.draw do

  root 'homes#index'

  devise_for :users

  get '/my_noobbets', to: "bets#my_noobbets"
  get '/my_noobbet/:id', to: "bets#show_noobbet", as: "my_noobbet"
  resources :bets do
    resources :lolteams, only: [:new, :create, :index]
  end

  get '/summoners/:id/score', to: "summoners#score", as: "score_summoner"
  resources :summoners, only: [:index, :show]

  authenticate :user, lambda { |u| u.email == "nathan.mh@gmail.com" || u.email == "test@test.com" } do
    mount Sidekiq::Web, at: "/sidekiq"
  end

end

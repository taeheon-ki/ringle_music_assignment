Rails.application.routes.draw do
  devise_for :users
  mount RingleMusic::Base => '/'
end

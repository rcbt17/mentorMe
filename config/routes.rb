Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :courses do
    resources :lessons, only: %i[index new create show]
  end
  resources :courses do
    post '/subscribe', to: 'course_subscriptions#create'
  end
end

Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :courses do
    resources :lessons, only: %i[index new create show] do
      resources :topics, only: %i[create show]
    end
  end
  resources :courses do
    post '/reviews', to: 'reviews#create'
    post '/subscribe', to: 'course_subscriptions#create'
  end

end

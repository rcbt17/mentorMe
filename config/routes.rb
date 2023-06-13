Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "/help", to: "pages#help"

  resources :courses do
    resources :lessons, only: %i[index new create show] do
      resources :topics, only: %i[create show]
    end
  end
  resources :courses do
    post '/reviews', to: 'reviews#create'
    post '/subscribe', to: 'course_subscriptions#create'
    delete '/unsubscribe', to: 'course_subscriptions#destroy'
  end

  # Handling posts
    post '/posts', to: 'posts#create'


    get "/help", to: "pages#help"

    get "/statistics/:id", to: "pages#statistics"

  namespace :api do
    post '/chat', to: 'ai#answer'
  end

end

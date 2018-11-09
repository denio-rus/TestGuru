Rails.application.routes.draw do
  root to: 'tests#index'

  devise_for :users, controllers: { sessions: 'sessions' }, path: :gurus, path_names: { sign_in: :login, sign_out: :logout }
 
  resources :tests, only: :index do 
    post :start, on: :member
  end

  resources :achievements, only: :index
  resources :badges, only: :index

  resources :test_passages, only: %i[show update] do
    get :result, on: :member
    post :gist, on: :member
  end

  resource :feedback, controller: 'feedback', only: %i[new create]

  namespace :admin do 
    resources :badges
    resources :gists, only: :index
    resources :tests do
      patch :update_inline, on: :member

      resources :questions, shallow: true, except: :index do
        resources :answers, shallow: true, except: :index 
      end
    end
  end
end

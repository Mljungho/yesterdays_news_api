Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/auth'
  namespace :api do
    namespace :admin do
      resources :articles, only: %i[index]
    end
    resources :articles, only: %i[index show create]
  end
end

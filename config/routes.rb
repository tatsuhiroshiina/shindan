Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'forms#enter'
  resources :forms, only: [:create, :delete] do
    member do
      get :result
    end
  end
  resources :solutions
end

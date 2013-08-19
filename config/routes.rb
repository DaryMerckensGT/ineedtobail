Ineedtobail::Application.routes.draw do
  root :to => "home#index"
  
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users do
    resources :messages
    resources :phones, only: [:new, :create, :index]
  end
  
  resources :calls, only: [] do
    member do
      get 'message'
    end
  end
end
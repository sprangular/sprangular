Sprangular::Engine.routes.draw do
  root to: 'home#index'

  namespace :store do
    post 'facebook/fetch'

    resources :products
    resource :cart do
      post :add_variant
      put :update_variant
      delete :remove_variant
    end
    resource :account
    resources :passwords
    resources :credit_cards
  end
end

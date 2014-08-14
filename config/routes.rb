Sprangular::Engine.routes.draw do
  scope module: 'sprangular' do
    root to: 'home#index'

    scope defaults: {format: :json} do
      post 'facebook/fetch'

      resource :env, controller: 'env'
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
end

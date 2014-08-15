Sprangular::Engine.routes.draw do
  scope module: 'sprangular' do
    root to: 'home#index'

    scope defaults: {format: :json} do
      post 'facebook/fetch'

      resources :taxonomies, only: :index
      resources :products, only: %i(index show)
      resource :cart do
        post :add_variant
        put :update_variant
        delete :remove_variant
      end
      resource :account
      resources :passwords
      resources :credit_cards
      resources :countries, only: :index
    end
  end
end

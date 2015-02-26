Sprangular::Engine.routes.draw do
  scope module: 'sprangular' do
    root to: 'home#index'
    resources "locale", only: :show, param: :locale

    scope '/api', defaults: {format: :json} do
      resources :taxonomies, only: :index
      get 'taxons/*permalink', to: 'taxons#show'
      resources :products, only: %i(index show)
      resource :cart do
        post :add_variant
        put :update_variant
        put :change_variant
        put :remove_adjustment
        delete :remove_variant
      end
      resource :account
      resources :passwords
      resources :credit_cards, only: :destroy
      resources :countries, only: :index
      resources :shipping_rates, only: :index
    end
  end

  put 'api/checkouts/:id/quick_update', to: 'spree/api/checkouts#quick_update'
end

Rails.application.routes.draw do
  mount Sprangular::Engine => "/"
  mount Spree::Core::Engine => '/spree'
end

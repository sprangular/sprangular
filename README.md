# Sprangular

Spree + Angular.js + Bootstrap

# [Live Demo](http://sprangular-demo.herokuapp.com)

## Features Overview

- Full Spree front-end
- Single page checkout
- 1-click checkout
- Product listing with infinite scroll
- Product search with auto-complete
- Easy to override templates/controllers
- Easy to add new routes/controllers/templates
- Full Google Analytics support via [Angularytics](https://github.com/mgonto/angularytics)
- Variant selection by option type
- Cart dropdown/popover
- Lookup shipping & tax by zip code (Planned)
- Newsletter signup form (optional) via [spree_chimpy](https://github.com/DynamoMTL/spree_chimpy)
- Example rails app [DynamoMTL/sprangular-demo](https://github.com/DynamoMTL/sprangular-demo)

## Installing

Create a rails project

```
rails new <your-app-name>
cd <you-app-name>
```

Add `spree`, `sprangular` and rails-assets source in your `Gemfile`. (notice we dont use the `spree` umbrella gem, because it contains the generic `spree_frontend`)

```
source 'https://rails-assets.org'

gem 'spree_core', '~> 2.3.4'
gem 'spree_api', '~> 2.3.4'
gem 'spree_backend', '~> 2.3.4'
gem 'spree_sample', '~> 2.3.4'
gem 'sprangular', github: 'DynamoMTL/sprangular'
```

Run bundler

```
bundle
```


Then install spree into your app

```
spree install --auto-accept
```

Then install sprangular:

```
rails generate sprangular:install
```

The admin is now accessible at http://localhost:3000/spree/admin

## Events

The following events are emitted

- cart.add
- cart.empty
- account.login
- account.logout
- loading.start
- loading.end

```coffeescript
# show modal when item added to cart
$scope.$on 'cart.add', ->
  $scope.showModal = true
```

### Caching

#### Templates

By default templates are fetched on-demand. Templates in `app/assets/templates/layout` are pre-generated and cached in the layout for increased speed.
You can add additional templates to be pre-cached, by setting `config.cached_paths`. Example:

```
# config/initializers/sprangular.rb
Sprangular::Engine.config.cached_paths += %w(products)
```

#### Data

Configure `cache_store` in your `config/environments/production.rb`

```ruby
config.action_controller.perform_caching = true
config.cache_store = :memory_store # or :dalli_store, :mem_cache_store
```

## Overriding

### Views

Copy the template to your `app/assets/templates` directory. The host app's version always takes presidence.

### Controllers/Resources

Create a `app/assets/javascripts/sprangular/controllers` or `resources` directory, and copy the gem version of the script. The host app's version always takes presidence.

## Adding

### Routes

Edit your `app/assets/javascripts/sprangular/extraRoutes.coffee` and add the route. For example:

```
Sprangular.defineRoutes ($routeProvider) ->

  $routeProvider
    .when '/about',
      template: '<h1>#1 Internet Site</h1>'
```

## Existing Stores

Sprangular configures Rack::Rewrite to provide a 301 redirect for your existing URLs. URLs like `/products` become `/#!/products`

## Development

This gem contains a dummy spree app in the `spec/dummy` folder. You can use that to test out changes when modifying this gem. Just bootstrap the database and start the server:

```
cd spec/dummy
rake db:reset AUTO_ACCEPT=1 && rake spree_sample:load
rails server
```

## License

MIT

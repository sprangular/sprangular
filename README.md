# Sprangular

Spree + Angular.js + Bootstrap

## Features Overview

- Full Spree front-end
- Single page checkout
- 1-click checkout
- Product listing with infinite scroll
- Product search with auto-complete
- Easy to override templates/controllers
- Easy to add new routes/controllers/templates
- Full Google Analytics support
- Advanced variant selection
- Cart dropdown/popover

## Installing

Add `sprangular` and rails-assets source to your Gemfile and `bundle`

```
source 'https://rails-assets.org'
gem 'sprangular'
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

### Caching templates

By default templates are fetched on-demand. Templates in `app/assets/templates/layout` are pre-generated and cached in the layout for increased speed.
You can add additional templates to be pre-cached, by setting `config.cached_paths`. Example:

```
# config/initializers/sprangular.rb
Sprangular::Engine.config.cached_paths += %w(products)
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
Sprangular.config ($routeProvider) ->

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

# Sprangular

Spree + Angular.js frontend

## Installing

Add `sprangular` and rails-assets source to your Gemfile

```
source 'https://rails-assets.org'
gem 'sprangular'
```

Mount the Sprangular and Spree engines in your `config/routes.rb`

```
mount Sprangular::Engine  => '/'
mount Spree::Core::Engine => '/spree'
```

The admin is now accessible at http://localhost:3000/spree/admin


Add `sprangular` to your asset pipeline.

In `application.js`, add sprangular:

```
//= require sprangular
```

In `application.css`, add sprangular (optional):

```
//= require sprangular
```

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

## Overriding

### Views

Copy the template to your `app/assets/templates` directory. The host app's version always takes presidence.

### Controllers/Resources

Create a `app/assets/javascripts/sprangular/controllers` or `resources` directory, and copy the gem version of the script. The host app's version always takes presidence.

## Adding

### Routes

Create a `app/assets/javascripts/sprangular/customRoutes.coffee` and add the route. For example:

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

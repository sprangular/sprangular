# Sprangular

Spree + Angular.js frontend

## Installing

Add `sprangular` and rails-assets source to your Gemfile

```
source 'https://rails-assets.org'
gem 'sprangular'
```

Mount the engine in your `config/routes.rb`

`mount Sprangular::Engine => "/"`

Add `sprangular` to your asset pipeline.

In `application.js`:

```
//= require sprangular
```

In `application.css`:

```
//= require bootstrap
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

Sprangular.config ['$routeProvider', ($routeProvider) ->

  $routeProvider
    .when '/about',
      template: '<h1>#1 Internet Site</h1>'
```


## Development

This gem contains a dummy spree app in the `spec/dummy` folder. You can use that to test out changes when modifying this gem. Just bootstrap the database and start the server:

```
cd spec/dummy
rake db:reset AUTO_ACCEPT=1 && rake spree_sample:load
rails server
```

## License

MIT

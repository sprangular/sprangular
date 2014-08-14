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

### Controllers

Create a `app/assets/javascripts/sprangular/controller` directory, and copy the gem version of the controller. The host app's version always takes presidence.

## Adding

## Development

This gem contains a dummy spree app in the `spec/dummy` folder. You can use that to test out changes when modifying this gem. Just bootstrap the database and start the server:

```
cd spec/dummy
rake db:reset AUTO_ACCEPT=1 && rake spree_sample:load
rails server
```

## License

MIT

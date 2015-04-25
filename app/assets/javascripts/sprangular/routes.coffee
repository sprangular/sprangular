Sprangular.catchAllRoutes = []

Sprangular.config ($routeProvider) ->

  $routeProvider
    .when '/',
      controller: 'HomeCtrl'
      templateUrl: 'home/index.html'
      resolve:
        products: (Catalog) ->
          Catalog.products()

    .when '/account',
      requires: {user: true}
      controller: 'AccountCtrl'
      templateUrl: 'account/show.html'
      resolve:
        user: (Account) ->
          Account.reload('full').then -> Account.user
        orders: (Orders) ->
          Orders.all()

    .when '/products',
      controller: 'ProductListCtrl'
      templateUrl: 'products/index.html'
      resolve:
        taxon: -> null
        products: (Catalog, $route) ->
          Catalog.products($route.current.params.search, 1)

    .when '/products/:id',
      controller: 'ProductCtrl'
      templateUrl: 'products/show.html'
      resolve:
        product: (Status, Catalog, $route) ->
          slug = $route.current.params.id

          Status.findCachedProduct(slug) || Catalog.find(slug)

    .when '/t/:path*',
      controller: 'ProductListCtrl'
      templateUrl: 'products/index.html'
      resolve:
        taxon: (Catalog, $route) ->
          Catalog.taxon($route.current.params.path)
        products: (Catalog, $route) ->
          Catalog.productsByTaxon($route.current.params.path)

    .when '/sign-in',
      requires: {anonymous: true}
      controller: 'SigninCtrl'
      templateUrl: 'account/signin.html'

    .when '/sign-up',
      requires: {anonymous: true}
      controller: 'SignupCtrl'
      templateUrl: 'account/signup.html'

    .when '/forgot-password',
      requires: {anonymous: true}
      controller: 'ForgotPasswordCtrl'
      templateUrl: 'account/forgot_password.html'

    .when '/reset-password/:token',
      requires: {anonymous: true}
      controller: 'ResetPasswordCtrl'
      templateUrl: 'account/reset_password.html'

    .when '/checkout',
      requires: {guest: true, cart: true}
      controller: 'CheckoutCtrl'
      templateUrl: 'checkout/index.html'
      resolve:
        countries: (Geography) -> Geography.getCountryList()
        order: (Cart) ->
          Cart.reload().then -> Cart.current
        user: (Account) ->
          if Account.isGuest
            {}
          else
            Account.reload('full').then -> Account.user

    .when '/checkout/complete',
      controller: 'CheckoutCompleteCtrl'
      templateUrl: 'checkout/complete.html'
      resolve:
        order: (Cart) ->
          Cart.lastOrder

    .when '/orders/:number',
      requires: {user: true}
      controller: 'OrderDetailCtrl'
      templateUrl: 'orders/show.html'
      resolve:
        order: (Orders, $route) ->
          Orders.find($route.current.params.number)

    .when '/404',
      templateUrl: '404.html'

    .when '/collections',
      controller: 'CollectionListCtrl'
      templateUrl: 'collections/index.html'
      resolve:
          collections: (Collections, $route)->
            Collections.list()

    .when '/collections/:id',
      controller: 'CollectionCtrl'
      templateUrl: 'collections/show.html'
      resolve:
        collection: (Collections, $route)->
          slug = $route.current.params.id
          Collections.find(slug)

    .when '/the-protagonist-podcast',
      controller: 'PageShowCtrl'
      templateUrl: 'static/podcasts.html'
      resolve:
        page: (StaticContent, $route)->
          StaticContent.find('the-protagonist-podcast')

    .when '/the-protagonist-podcast/:id',
      controller: 'PageShowCtrl'
      templateUrl: 'static/podcast.html'
      resolve:
        page: (StaticContent, $route)->
          slug = $route.current.params.id
          StaticContent.find(slug)

    .when '/press',
      controller: 'PressCtrl'
      templateUrl: 'press/index.html'
      resolve:
        press_releases: (Press, $route)->
          Press.list()


  _.each Sprangular.catchAllRoutes, (route) ->
    $routeProvider.when(route.path, route.options)

  $routeProvider.otherwise(templateUrl: '404.html')

Sprangular.defineCatchAllRoute = (path, options={}) ->
  @catchAllRoutes.push(path: path, options: options)

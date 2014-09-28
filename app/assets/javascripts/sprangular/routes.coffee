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
          Account.init().then -> Account.user

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
        product: (Catalog, $route) ->
          Catalog.find($route.current.params.id)

    .when '/t/:path*',
      controller: 'ProductListCtrl'
      templateUrl: 'products/index.html'
      resolve:
        taxon: (Catalog, $route) ->
          Catalog.taxon($route.current.params.path)
        products: (Catalog, $route) ->
          Catalog.productsByTaxon($route.current.params.path)

    .when '/sign-in',
      requires: {guest: true}
      controller: 'SigninCtrl'
      templateUrl: 'account/signin.html'

    .when '/sign-up',
      requires: {guest: true}
      controller: 'SignupCtrl'
      templateUrl: 'account/signup.html'

    .when '/forgot-password',
      requires: {guest: true}
      controller: 'ForgotPasswordCtrl'
      templateUrl: 'account/forgot_password.html'

    .when '/reset-password/:token',
      requires: {guest: true}
      controller: 'ResetPasswordCtrl'
      templateUrl: 'account/reset_password.html'

    .when '/checkout',
      requires: {user: true, cart: true}
      redirectTo: '/checkout/details'

    .when '/checkout/details',
      requires: {user: true, cart: true}
      controller: 'CheckoutDetailsCtrl'
      templateUrl: 'checkout/details.html'

    .when '/checkout/confirm',
      requires: {user: true, cart: true}
      controller: 'CheckoutConfirmCtrl'
      templateUrl: 'checkout/confirm.html'

    .when 'checkout/complete',
      controller: 'CheckoutCompleteCtrl'
      templateUrl: 'checkout/complete.html'

    .otherwise
      templateUrl: '404.html'

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

    .when '/products',
      controller: 'ProductListCtrl'
      templateUrl: 'products/index.html'
      resolve:
        products: (Catalog) ->
          Catalog.products()

    .when '/products/:id',
      controller: 'ProductCtrl'
      templateUrl: 'products/show.html'
      resolve:
        product: (Catalog, $route) ->
          Catalog.find($route.current.params.id)

    .when '/sign-in',
      requires: {guest: true}
      controller: 'SigninCtrl'
      templateUrl: 'account/signin.html'

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
      controller: 'CheckoutCtrl'
      templateUrl: 'checkout/index.html'

    .when '/checkout/shipping',
      requires: {user: true, cart: true}
      controller: 'CheckoutShippingCtrl'
      templateUrl: 'checkout/shipping.html'

    .when '/checkout/billing',
      requires: {user: true, cart: true}
      controller: 'CheckoutBillingCtrl'
      templateUrl: 'checkout/billing.html'

    .when '/checkout/delivery',
      requires: {user: true, cart: true}
      controller: 'CheckoutDeliveryCtrl'
      templateUrl: 'checkout/delivery.html'

    .when '/checkout/payment',
      requires: {user: true, cart: true}
      controller: 'CheckoutPaymentCtrl'
      templateUrl: 'checkout/payment.html'

    .when '/checkout/confirm',
      requires: {user: true, cart: true}
      controller: 'CheckoutConfirmCtrl'
      templateUrl: 'checkout/confirm.html'

    .when 'checkout/complete',
      controller: 'CheckoutCompleteCtrl'
      templateUrl: 'checkout/complete.html'

    .otherwise '/'

Sprangular.config ($stateProvider, $urlRouterProvider) ->

  # Trailing slash redirect
  # $urlRouterProvider.rule ($injector, $location) ->
  #   path = $location.url()
  #   return  if path[path.length - 1] is "/" or path.indexOf("/?") > -1
  #   return path.replace("?", "/?") if path.indexOf("?") > -1
  #   path + "/"

  $urlRouterProvider.otherwise '/'

  $stateProvider
    .state 'home',
      url: '/'
      views:
        'main':
          controller: 'HomeCtrl'
          templateUrl: '/assets/home/index.html'
    .state 'account',
      url: '/account'
      views:
        'main':
          controller: 'AccountCtrl'
          templateUrl: '/assets/account/show.html'
    .state 'productList',
      url: '/products'
      views:
        'main':
          controller: 'ProductListCtrl'
          templateUrl: '/assets/products/index.html'
    .state 'productShow',
      url: '/products/:id'
      views:
        'main':
          controller: 'ProductCtrl'
          templateUrl: '/assets/products/show.html'
      # resolve:
        # catalog: (Catalog) -> Catalog.fetch()
    .state 'gateKeeper',
      url: '/gate/:nextState/:productId',
      views:
        'signin':
          controller: 'SigninCtrl'
          templateUrl: '/assets/account/signin.html'
    .state 'forgotPassword',
      url: '/forgot-password',
      views:
        'signin':
          controller: 'ForgotPasswordCtrl'
          templateUrl: '/assets/account/forgot_password.html'
    .state 'resetPassword',
      url: '/reset-password/:token'
      views:
        'signin':
          controller: 'ResetPasswordCtrl'
          templateUrl: '/assets/account/reset_password.html'
    .state 'checkout',
      url: '/checkout'
      views:
        'main':
          controller: 'CheckoutCtrl'
          templateUrl: '/assets/checkout/index.html'
    .state 'checkout.shipping',
      url: '/shipping'
      # controller: 'CheckoutCtrl'
      views:
        'checkout-step':
          controller: 'CheckoutShippingCtrl'
          templateUrl: '/assets/checkout/shipping.html'
    .state 'checkout.billing',
      url: '/billing'
      # controller: 'CheckoutCtrl'
      views:
        'checkout-step':
          controller: 'CheckoutBillingCtrl'
          templateUrl: '/assets/checkout/billing.html'
    .state 'checkout.delivery',
      url: '/delivery'
      # controller: 'CheckoutCtrl'
      views:
        'checkout-step':
          controller: 'CheckoutDeliveryCtrl'
          templateUrl: '/assets/checkout/delivery.html'
    .state 'checkout.payment',
      url: '/payment'
      # controller: 'CheckoutCtrl'
      views:
        'checkout-step':
          controller: 'CheckoutPaymentCtrl'
          templateUrl: '/assets/checkout/payment.html'
    .state 'checkout.confirm',
      url: '/confirm'
      # controller: 'CheckoutCtrl'
      views:
        'checkout-step':
          controller: 'CheckoutConfirmCtrl'
          templateUrl: '/assets/checkout/confirm.html'
    .state 'checkout.complete',
      url: '/complete'
      # controller: 'CheckoutCtrl'
      views:
        'checkout-step':
          controller: 'CheckoutCompleteCtrl'
          templateUrl: '/assets/checkout/complete.html'

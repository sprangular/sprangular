Sprangular.config ($routeProvider) ->

  $routeProvider
    .when '/',
      controller: 'HomeCtrl'
      templateUrl: 'home/index.html'

    .when '/account',
      controller: 'AccountCtrl'
      templateUrl: 'account/show.html'

    .when '/products',
      controller: 'ProductListCtrl'
      templateUrl: 'products/index.html'

    .when '/products/:id',
      controller: 'ProductCtrl'
      templateUrl: 'products/show.html'

    .when '/sign-in',
      controller: 'SigninCtrl'
      templateUrl: 'account/signin.html'

    .when '/forgot-password',
      controller: 'ForgotPasswordCtrl'
      templateUrl: 'account/forgot_password.html'

    .when '/reset-password/:token',
      controller: 'ResetPasswordCtrl'
      templateUrl: 'account/reset_password.html'

    .when '/checkout',
      controller: 'CheckoutCtrl'
      templateUrl: 'checkout/index.html'

    .when '/checkout/shipping',
      controller: 'CheckoutShippingCtrl'
      templateUrl: 'checkout/shipping.html'

    .when '/checkout/billing',
      controller: 'CheckoutBillingCtrl'
      templateUrl: 'checkout/billing.html'

    .when '/checkout/delivery',
      controller: 'CheckoutDeliveryCtrl'
      templateUrl: 'checkout/delivery.html'

    .when '/checkout/payment',
      controller: 'CheckoutPaymentCtrl'
      templateUrl: 'checkout/payment.html'

    .when '/checkout/confirm',
      controller: 'CheckoutConfirmCtrl'
      templateUrl: 'checkout/confirm.html'

    .when 'checkout/complete',
      controller: 'CheckoutCompleteCtrl'
      templateUrl: 'checkout/complete.html'

    .otherwise '/'

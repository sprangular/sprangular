Sprangular.controller 'CheckoutDetailsCtrl', ($scope, $location, Account, Cart, Checkout) ->
  $scope.order =
    creditCard: new Sprangular.CreditCard
    billingAddress: new Sprangular.Address
    shippingAddress: new Sprangular.Address
    sameBillingShippingAddress: true

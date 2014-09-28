Sprangular.controller 'CheckoutDetailsCtrl', ($scope, $location, countries, Account, Cart, Checkout) ->
  $scope.countries = countries
  $scope.order = new Sprangular.Order

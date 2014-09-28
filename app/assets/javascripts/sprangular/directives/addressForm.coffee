Sprangular.directive 'addressForm', ->
  restrict: 'E'
  templateUrl: 'addresses/form.html'
  scope:
    address: '='
  controller: ($scope, Geography) ->
    $scope.selectedCountry = null

    Geography.getCountryList().then (countries) ->
      $scope.countries = countries

    $scope.$watch (-> $scope.address.countryId), (newCountryId) ->
      return unless newCountryId
      $scope.selectedCountry = _.find($scope.countries, (c) -> c.id == newCountryId)

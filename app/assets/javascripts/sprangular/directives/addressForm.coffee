Sprangular.directive 'addressForm', ->
  restrict: 'E'
  templateUrl: 'addresses/form.html'
  scope:
    address: '='
    countries: '='
  controller: ($scope) ->
    $scope.selectedCountry = null

    $scope.$watch (-> $scope.address.countryId), (newCountryId) ->
      return unless newCountryId
      $scope.selectedCountry = _.find($scope.countries, (c) -> c.id == newCountryId)

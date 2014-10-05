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
      $scope.selectedCountry = _.find($scope.countries, (country) -> country.id == newCountryId)
      $scope.address.country = $scope.selectedCountry

    $scope.$watch (-> $scope.address.stateId), (newStateId) ->
      return unless newStateId
      state = _.find($scope.selectedCountry.states, (state) -> state.id == newStateId)
      $scope.address.state = state

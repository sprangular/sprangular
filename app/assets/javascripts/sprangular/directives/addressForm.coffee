Sprangular.directive 'addressForm', ->
  restrict: 'E'
  templateUrl: 'addresses/form.html'
  scope:
    address: '='
    countries: '='
    disabled: '='
  controller: ($scope) ->
    $scope.selectedCountry = null

    $scope.$watch (-> $scope.address.countryId), (newCountryId) ->
      return unless newCountryId

      address = $scope.address

      $scope.selectedCountry = _.find($scope.countries, (country) -> country.id == newCountryId)
      address.country = $scope.selectedCountry

      if address.state && address.state.country_id != newCountryId
        address.stateId = null
        address.state = null

    $scope.$watch (-> $scope.address.stateId), (newStateId) ->
      return unless newStateId
      state = _.find($scope.selectedCountry.states, (state) -> state.id == newStateId)
      $scope.address.state = state

  link: (element, attrs) ->
    attrs.disabled = false unless attrs.disabled?

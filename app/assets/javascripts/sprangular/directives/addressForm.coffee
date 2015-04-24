Sprangular.directive 'addressForm', ->
  restrict: 'E'
  templateUrl: 'addresses/form.html'
  scope:
    address: '='
    countries: '='
    disabled: '=disabledFields'
    submitted: '='
  controller: ($scope, Account) ->
    $scope.user = Account.user
    $scope.selectedCountry = null
    $scope.hasErrors = false

    $scope.$watchGroup ['address.firstname', 'address.lastname', 'address.address1', 'address.address2', 'address.city', 'address.stateId', 'address.countryId', 'address.zipcode', 'address.phone'], ->
      return unless $scope.submitted

      address = $scope.address
      address.validate()
      errors = address.errors
      $scope.hasErrors = errors && Object.keys(errors).length > 0

    $scope.$watch 'address.countryId', (newCountryId) ->
      return unless newCountryId

      address = $scope.address

      $scope.selectedCountry = _.find($scope.countries, (country) -> country.id == newCountryId)
      address.country = $scope.selectedCountry

      if address.state && address.state.country_id != newCountryId
        address.stateId = null
        address.state = null

    $scope.$watch 'address.stateId', (newStateId) ->
      return unless newStateId
      state = _.find($scope.selectedCountry.states, (state) -> state.id == newStateId)
      $scope.address.state = state

  link: (element, attrs) ->
    attrs.disabled = false unless attrs.disabled?

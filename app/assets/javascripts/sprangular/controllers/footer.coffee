Sprangular.controller "FooterCtrl", ($scope, $location, Account, Catalog, Status) ->

  $scope.catalog = Catalog
  $scope.account = Account

  $scope.goToMyAccount = ->
    $location.path '/account'

  $scope.changeLng = (lng, url) ->
    $.ajax(
      type: 'POST'
      url: '/api/locale/set'
      data:
        locale: lng
        authenticity_token: $('meta[name="csrf-token"]').attr('content')
    ).success ->
      window.location.reload()
    return

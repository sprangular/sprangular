Sprangular.controller 'HomeCtrl', ($scope, $stateParams, Status, Catalog, Cart) ->

  Catalog.fetch().then (catalog) ->
    console.log 'catalog--', catalog
    $scope.callout =
      product: catalog.findProduct { slug: "glossier-phase-i" }
      variant: catalog.findProduct({ slug: "glossier-phase-i" }).variants[0]
    Status.pageTitle = "Sprangular Homepage"
    Status.bodyClass = "p-home"
    window.prerenderReady = true

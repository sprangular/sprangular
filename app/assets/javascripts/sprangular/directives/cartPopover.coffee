'use strict'

Sprangular.directive 'cartPopover', ($timeout, $rootScope, $popover) ->
  restrict: 'E'
  template: '<span/>'
  link: (scope, element, attrs) ->
    content = {}

    attrs.autoClose = true
    attrs.trigger = "manual"
    attrs.template = "cart/popover.html"
    attrs.content = content

    popover = $popover(element, attrs)

    $rootScope.$on 'cart.add', (event, args) ->
      content.variant = args.variant
      content.qty = args.qty

      popover.show()

      $timeout(popover.hide, 3000)

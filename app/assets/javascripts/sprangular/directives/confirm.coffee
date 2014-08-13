# <button ng-click="sayHi()" ng-confirm-click="Would you like to say hi?">Say hi to {{ name }}</button>

Sprangular.directive "ngConfirmClick", [->
  priority: 1
  terminal: true
  link: (scope, element, attr) ->
    msg = attr.ngConfirmClick or "Are you sure?"
    clickAction = attr.ngClick
    element.bind "click", (event) ->
      scope.$eval clickAction  if window.confirm(msg)
      return

    return
]
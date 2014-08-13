# Sprangular.directive 'dirFCounter', ->
#   restrict: 'AE'
#   scope:
#     number: '=ngModel'
#   link: (scope, counter, attrs) ->
#     scope.update = (delta) ->
#       # scope.number = if scope.number = 0 or is NaN or is undefined then 0
#       console.log 'scope.number', scope.number
#       # scope.number = 0 if scope.number <= 0 or scope.number is NaN or scope.number is undefined
#       scope.number += delta unless (scope.number + delta) is 0
#     scope.change = ->
#       console.log 'change', scope.number

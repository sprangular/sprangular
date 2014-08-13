# a ng-gif-player="path/to/animated.gif"
# -- img ng-src="path/to/still.gif"

Sprangular.directive "ngGifPlayer", [->
  # priority: 1
  # terminal: true
  link: (scope, element, attr) ->
    $el = angular.element(element)
    $img = $el.find 'img'
    $el.on 'click', ->
      src = if $el.hasClass 'is-gif--anim' then $img.attr 'ng-src' else attr.ngGifPlayer
      $img.attr 'src', src
      $el.toggleClass 'is-gif--anim'
]

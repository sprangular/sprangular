Sprangular.factory 'Flash', ($timeout) ->
  flashes: []

  add: (type, message) ->
    flash = type: type, message: message

    @flashes.push(flash)
    @timeout(flash)

  timeout: (flash) ->
    self = this
    $timeout((-> self.remove(flash)), 2500)

  success: (message) -> @add('success', message)
  info:    (message) -> @add('info',    message)
  error:   (message) -> @add('error',   message)

  remove: (flash) ->
    @flashes = @flashes.filter (x) -> x != flash

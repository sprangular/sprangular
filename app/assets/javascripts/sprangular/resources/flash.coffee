Sprangular.factory 'Flash', ($timeout) ->
  messages: []

  add: (type, message) ->
    flash = type: type, text: message

    @messages.push(flash)
    @timeout(flash)

  timeout: (flash) ->
    self = this
    $timeout((-> self.remove(flash)), 2500)

  success: (message) -> @add('success', message)
  info:    (message) -> @add('info',    message)
  error:   (message) -> @add('danger',   message)

  remove: (flash) ->
    @messages = @messages.filter (x) -> x != flash

  hasMessages: () ->
    @messages.length > 0

Sprangular.factory 'Flash', ($timeout, $translate) ->
  messages: []

  add: (type, translate_key) ->
    self = this

    $translate(translate_key).then (translated) ->
      flash = type: type, text: translated

      self.messages.push(flash)
      self.timeout(flash)

  timeout: (flash) ->
    self = this
    $timeout((-> self.remove(flash)), 2500)

  success: (translate_key) -> @add('success', translate_key)
  info:    (translate_key) -> @add('info',    translate_key)
  error:   (translate_key) -> @add('danger',  translate_key)

  remove: (flash) ->
    @messages = @messages.filter (x) -> x != flash

  hasMessages: () ->
    @messages.length > 0

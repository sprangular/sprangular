Sprangular.run ($translate) ->
  keys = [
    "required"
    "greaterThan"
    "greaterThanOrEqual"
    "lessThan"
    "lessThanOrEqual"
    "regex"
    "length"
    "lengthGreaterThan"
    "lengthLessThan"
    "number"
  ]

  translate = (key) ->
    $translate("validation.#{key}").then (text) ->
      Validity.MESSAGES[key] = text

  for key in keys
    translate(key)

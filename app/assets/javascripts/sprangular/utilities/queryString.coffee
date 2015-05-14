Sprangular.parseQueryString = (uri) ->
  queryString = {}

  addArrayValue = (key, value) ->
    (queryString[key] ||= []).push(value)

  addDictValue = (name, key, value) ->
    (queryString[name] ||= {})[key] = value

  addValue = (key, value) ->
    match = key.match(/^([^\[]+)(\[(.*)\])$/i)

    if match
      if match[3]
        addDictValue(match[1], match[3], value)
      else
        addArrayValue(match[1], value)
    else
      queryString[key] = value

  uri.replace new RegExp("([^?=&]+)(=([^&]*))?", "g"), (_, key, _, value) -> addValue(key, value)
  queryString

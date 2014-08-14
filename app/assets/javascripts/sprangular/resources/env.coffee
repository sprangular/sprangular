Sprangular.service "Env", ($http, $q) ->
  env = {config: {}}

  $http.get("/env")
    .success (data) ->
      env.env = data.env
      env.config = data.config

  env

Sprangular.service 'Geography', ($http) ->
  getCountryList: ->
    $http.get('/api/countries', cache: true, useApiDomain: true)
         .then (response) -> response.data

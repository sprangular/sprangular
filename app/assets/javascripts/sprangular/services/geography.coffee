Sprangular.service 'Geography', ($http) ->
  getCountryList: ->
    $http.get('api/countries', cache: true)
         .then (response) -> response.data

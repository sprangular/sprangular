angular.module 'rawFilter', []
  .filter 'raw', ($sce) ->
    (input) ->
      $sce.trustAsHtml(input)

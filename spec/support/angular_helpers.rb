module AngularHelpers
  def wait_for_loading
    page.evaluate_script <<-JS
      angular.element(document).ready(function() {
        var app = angular.element(document.querySelector('[ng-app], [data-ng-app]'));
        var injector = app.injector();

        injector.invoke(function($rootScope, Status) {
          var ready = function() { window.angularReady = true; };

          $rootScope.$on("$routeChangeStart", function() {
            window.angularReady = false;
          });

          $rootScope.$on("$routeChangeSuccess", ready);
          $rootScope.$on("$routeChangeError", ready);

          $rootScope.$watch(function() {
            return Status.isLoading;
          },
          function(isLoading) {
            window.angularReady = !isLoading;
          });
        });
      });
    JS
  end
end

module RouteChange
  def wait_for_route_changes
    page.evaluate_script <<-JS
      angular.element(document).ready(function() {
        var app = angular.element(document.querySelector('[ng-app], [data-ng-app]'));
        var injector = app.injector();

        injector.invoke(function($rootScope) {
          $rootScope.$on("$routeChangeStart", function() {
            window.angularReady = false;
          });

          var ready = function() { window.angularReady = true };

          $rootScope.$on("$routeChangeSuccess", ready);
          $rootScope.$on("$routeChangeError", ready);
        });
      });
    JS
  end
end

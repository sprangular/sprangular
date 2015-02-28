module Sprangular
  ##
  # API Endpoint to set locale for session
  class LocaleController < Sprangular::BaseController
    def show
      session[:locale] = params[:locale]

      respond_to do |format|
        format.js { render js: "window.location.reload" }
        format.html { redirect_to sprangular_engine.root_path }
      end
    end
  end
end

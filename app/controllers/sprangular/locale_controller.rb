module Sprangular
  ##
  # API Endpoint to set locale for session
  class LocaleController < Sprangular::BaseController
    def set
      session[:locale] = params[:locale]

      respond_to do |format|
        format.json { render json: true }
        format.html { redirect_to root_path }
      end
    end
  end
end

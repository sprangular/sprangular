class Spree::UserSessionsController < Devise::SessionsController
  helper 'spree/base', 'spree/store', Spree::Api::ApiHelpers

  if Spree::Auth::Engine.dash_available?
    helper 'spree/analytics'
  end

  include Spree::Core::ControllerHelpers::Auth
  include Spree::Core::ControllerHelpers::Common
  include Spree::Core::ControllerHelpers::Order
  include Spree::Core::ControllerHelpers::SSL
  include Spree::Core::ControllerHelpers::Store
  include Sprangular::Csrf

  ssl_required :new, :create, :destroy, :update
  ssl_allowed :login_bar

  def create
    authenticate_spree_user!

    if spree_user_signed_in?
      respond_to do |format|
        format.html {
          flash[:success] = Spree.t(:logged_in_succesfully)
          redirect_back_or_default(after_sign_in_path_for(spree_current_user))
        }
        format.json {
          @user = spree_current_user
          @order = current_order
          @current_user_roles = @user.spree_roles

          render json: @user,
                 root: false,
                 serializer: Sprangular::UserSerializer
        }
      end
    else
      respond_to do |format|
        format.html {
          flash.now[:error] = t('devise.failure.invalid')
          render :new
        }
        format.json {
          render json: { error: t('devise.failure.invalid') }, status: :unprocessable_entity, layout: false
        }
      end
    end
  end

  def destroy
    redirect_path = after_sign_out_path_for(resource_name)
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
    yield resource if block_given?

    # We actually need to hardcode this as Rails default responder doesn't
    # support returning empty response on GET request
    respond_to do |format|
      format.json { render json: {} }
      format.all { head :no_content }
      format.any(*navigational_formats) { redirect_to redirect_path }
    end
  end

  private
    def accurate_title
      Spree.t(:login)
    end

    def redirect_back_or_default(default)
      redirect_to(session["spree_user_return_to"] || default)
      session["spree_user_return_to"] = nil
    end
end

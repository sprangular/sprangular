class Sprangular::Store::AccountsController < Sprangular::Store::BaseController
  before_filter :check_authorization, except: :create

  def create
    user = Spree::User.new spree_user_params
    if user.save
      sign_in :spree_user, user
    end

    respond_with user
  end

  def show
    authorize! :show, @user
  end

  def update
    authorize! :update, @user
    @user.update_attributes spree_user_params

    respond_with @user
  end

private

  def spree_user_params
    params.require(:spree_user).permit(Spree::PermittedAttributes.user_attributes)
  end
end

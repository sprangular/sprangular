class Sprangular::AccountsController < Sprangular::BaseController
  before_filter :check_authorization, except: :create

  def create
    @user = Spree::User.create(spree_user_params)

    sign_in(:spree_user, @user) if @user.persisted?

    render 'show'
  end

  def show
    authorize! :show, @user
  end

  def update
    authorize! :update, @user
    @user.update_attributes spree_user_params

    render 'show'
  end

private

  def spree_user_params
    params.require(:spree_user).permit(Spree::PermittedAttributes.user_attributes)
  end
end

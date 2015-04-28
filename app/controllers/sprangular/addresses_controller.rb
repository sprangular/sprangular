class Sprangular::AddressesController < Sprangular::BaseController
  before_filter :check_authorization

  def destroy
    authorize! :update, @user

    address = @user.addresses.find params[:id]
    address.destroy

    respond_with address
  end
end
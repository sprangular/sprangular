class Sprangular::AddressesController < Sprangular::BaseController
  before_filter :check_authorization

  def destroy
    authorize! :update, @user

    address = @user.addresses.find params[:id]
    address.destroy

    render json: address,
                scope: @user,
                serializer: Sprangular::AddressSerializer,
                root: false
  end
end
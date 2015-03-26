class Sprangular::OrdersController < Sprangular::BaseController
  before_filter :check_authorization

  def show
    authorize! :show, @user

    @order = Spree::Order.where(number: params[:id]).first!

    render 'spree/api/orders/show'
  end
end

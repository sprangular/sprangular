class Sprangular::OrdersController < Sprangular::BaseController
  before_filter :check_authorization

  def index
    authorize! :show, @user

    @orders = @user.orders.complete

    render json: @orders,
           scope: current_spree_user,
           each_serializer: Sprangular::LiteOrderSerializer,
           root: false
  end

  def show
    authorize! :show, @user

    @order = Spree::Order.where(number: params[:id]).first!

    render json: @order,
           scope: current_spree_user,
           serializer: Sprangular::OrderSerializer,
           root: false
  end
end

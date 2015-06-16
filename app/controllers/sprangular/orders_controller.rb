class Sprangular::OrdersController < Sprangular::BaseController
  before_filter :check_authorization, only: :index

  def index
    authorize! :show, @user

    @orders = @user.orders.complete

    render json: @orders,
           scope: current_spree_user,
           each_serializer: Sprangular::LiteOrderSerializer,
           root: false
  end

  def show
    token = request.headers['X-Spree-Order-Token']

    if token.present?
      @order = Spree::Order.find_by!(number: params[:id], guest_token: token)
    else
      check_authorization
      authorize! :show, @user
      @order = @user.orders.find_by!(number: params[:id])
    end

    render json: @order,
           scope: current_spree_user,
           serializer: Sprangular::OrderSerializer,
           root: false
  end
end

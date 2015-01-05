class Sprangular::HomeController < Sprangular::BaseController
  respond_to :html
  layout 'sprangular/application'

  def index
    @user  = current_spree_user
    @order = current_order
  end
end

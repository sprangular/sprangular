class Sprangular::Store::ProductsController < Sprangular::Store::BaseController

  def index
    @products = Spree::Product.page(params[:page]).per(params[:per_page])
    render 'spree/api/products/index'
  end

end

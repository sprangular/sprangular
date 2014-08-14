class Sprangular::ProductsController < Sprangular::BaseController

  def index
    @products = Spree::Product.active.page(params[:page]).per(params[:per_page])

    render 'spree/api/products/index'
  end

  def show
    @product = Spree::Product.active.where(slug: params[:id]).first!

    render 'spree/api/products/show'
  end

end

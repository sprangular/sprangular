class Sprangular::ProductsController < Sprangular::BaseController

  def index
    @products = Spree::Product.active
  end

  def show
    @product = Spree::Product.active.where(slug: params[:id]).first!

    render 'spree/api/products/show'
  end

end

class Sprangular::ProductsController < Sprangular::BaseController

  def index
    @products = Spree::Product.active.includes(:option_types, :product_properties, variants: [:images, :option_values])
    @products = @products.ransack(params[:q]).result if params[:q]
    @products = @products.distinct.page(params[:page]).per(params[:per_page])

    render 'spree/api/products/index'
  end

  def show
    @product = Spree::Product.active.where(slug: params[:id]).first!

    render 'spree/api/products/show'
  end

end

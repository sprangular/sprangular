class Sprangular::ProductsController < Sprangular::BaseController
  def index
    @products = product_scope.where("spree_prices.amount IS NOT NULL").where("spree_prices.currency" => current_currency) unless Spree::Config.show_products_without_price
    @products = @products.ransack(params[:q]).result if params[:q]
    @products = @products.distinct.page(params[:page]).per(params[:per_page])
    @cache_key = [I18n.locale, @current_user_roles.include?('admin'), current_currency, params[:q], params[:per_page], params[:per_page]]

    render 'index'
  end

  def show
    @product = product_scope.where(slug: params[:id]).first!

    render 'spree/api/products/show'
  end

private
  def product_scope
    Spree::Product.active.includes(:option_types, :taxons, master: [:images, :option_values, :prices], product_properties: [:property], variants: [:images, :option_values, :prices])
  end
end

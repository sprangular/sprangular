class Sprangular::ProductsController < Sprangular::BaseController
  def index
    @products = product_scope
    @products = @products.where("spree_prices.amount IS NOT NULL").where("spree_prices.currency" => current_currency) unless Spree::Config.show_products_without_price
    @products = @products.ransack(params[:q]).result if params[:q]
    @products = @products.distinct.page(params[:page]).per(params[:per_page])
    @cache_key = [I18n.locale, @current_user_roles.include?('admin'), current_currency, params[:q], params[:per_page], params[:per_page]]

    render json: @products,
           each_serializer: Sprangular::ProductSerializer,
           root: :products,
           meta: {
             count: @products.count,
             total_count: @products.total_count,
             current_page: params[:page] ? params[:page].to_i : 1,
             per_page: params[:per_page] || Kaminari.config.default_per_page,
             pages: @products.num_pages
           }
  end

  def show
    @product = product_scope.find_by!(slug: params[:id])

    render json: @product,
           root: false,
           serializer: Sprangular::ProductSerializer
  end

  private

  def product_scope
    Spree::Product.active.includes(:option_types, :taxons, master: %i(images option_values prices), product_properties: [:property], variants: %i(images option_values prices))
  end
end

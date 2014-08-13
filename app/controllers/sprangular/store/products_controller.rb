class Sprangular::Store::ProductsController < Sprangular::Store::BaseController

  def index
    @products = Spree::Product.all
  end

end

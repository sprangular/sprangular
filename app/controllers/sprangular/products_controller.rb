class Sprangular::ProductsController < Sprangular::BaseController

  def index
    @products = Spree::Product.active
  end

end

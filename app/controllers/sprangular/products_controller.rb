class Sprangular::ProductsController < Sprangular::BaseController

  def index
    @products = Spree::Product.all
  end

end

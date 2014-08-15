class Sprangular::CountriesController < Sprangular::BaseController
  def index
    @countries = Spree::Country
                  .includes(:states)
                  .order(:name)
  end
end

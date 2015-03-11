class Sprangular::CountriesController < Sprangular::BaseController
  def index
    @countries = Spree::Country.includes(:states).order(:name)

    render json: @countries,
      root: false,
      each_serializer: Sprangular::CountrySerializer
  end
end

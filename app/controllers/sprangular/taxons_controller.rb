class Sprangular::TaxonsController < Sprangular::BaseController
  def show
    @taxon = Spree::Taxon.where(permalink: params[:permalink]).first!
    render 'spree/api/taxons/show'
  end
end

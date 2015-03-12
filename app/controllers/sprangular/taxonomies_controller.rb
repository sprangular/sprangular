class Sprangular::TaxonomiesController < Sprangular::BaseController
  def index
    @taxonomies = Spree::Taxonomy.order('name').includes(root: :children)

    render json: @taxonomies,
           each_serializer: Sprangular::TaxonomySerializer
  end
end

class Sprangular::TaxonomiesController < ApplicationController
  def index
    @taxonomies = Spree::Taxonomy.order('name').includes(root: :children)

    render json: @taxonomies,
           each_serializer: Sprangular::TaxonomySerializer
  end
end

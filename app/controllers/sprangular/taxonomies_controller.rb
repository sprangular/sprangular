class Sprangular::TaxonomiesController < Sprangular::BaseController
  def index
    @taxonomies = Spree::Taxonomy.order('name').includes(root: :children)
  end
end

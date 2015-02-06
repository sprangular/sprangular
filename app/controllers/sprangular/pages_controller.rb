class Sprangular::PagesController < Sprangular::BaseController
  def show
    @page = Spree::Page.visible.where(slug: slug_params).first!
  end
  private
  def slug_params
    "/#{params[:id]}"
  end
end

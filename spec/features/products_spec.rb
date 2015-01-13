# encoding: utf-8
require 'spec_helper'

describe "Visiting Products", js: true do
  include_context "custom products"

  let(:store_name) do
    ((first_store = Spree::Store.first) && first_store.name).to_s
  end

  before(:each) do
    visit sprangular_engine.root_path
  end

  it "should increment counter when product added to cart" do
    product = page.all(:css, '.product')[4]
    product.hover
    product.click_link('a')

    expect(page).to have_content("Ruby on Rails Baseball Jersey")
    expect(page).to have_content("$19.99")

    page.find(:css, '.add-to-cart').click

    expect(page).to have_css(".cart-link .cart-qty", text: "1")
  end

  describe 'meta tags and title' do
    let(:jersey) { Spree::Product.find_by_name('Ruby on Rails Baseball Jersey') }
    let(:metas) { { :meta_description => 'Brand new Ruby on Rails Jersey', :meta_keywords => 'ror, jersey, ruby' } }

    before do
      jersey.update_attributes(metas)
      visit sprangular_engine.root_path
      product = page.all(:css, '.product')[4]
      product.hover
      product.click_link('a')
    end

    it 'should return the correct title when displaying a single product' do
      expect(page).to have_title('Ruby on Rails Baseball Jersey - ' + store_name)

      within('h1') do
        expect(page).to have_content('Ruby on Rails Baseball Jersey')
      end
    end

    it 'displays metas' do
      expect(page).to have_meta(:description, 'Brand new Ruby on Rails Jersey')
      expect(page).to have_meta(:keywords, 'ror, jersey, ruby')
    end
  end

end

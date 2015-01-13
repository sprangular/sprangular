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
    binding.pry

    expect(page).to have_css(".cart-link .cart-qty", text: "1")
  end

end

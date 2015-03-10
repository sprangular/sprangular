# encoding: utf-8
require 'spec_helper'

describe "Visiting Products", js: true do
  include_context "custom products"

  let(:store_name) do
    ((first_store = Spree::Store.first) && first_store.name).to_s
  end

  before do
    Spree::Config.products_per_page = 8
  end

  describe 'meta tags and title' do
    let(:jersey) { Spree::Product.find_by_name('Ruby on Rails Baseball Jersey') }
    let(:metas) { { meta_description: 'Brand new Ruby on Rails Jersey', meta_keywords: 'ror, jersey, ruby' } }

    before do
      jersey.update_attributes(metas)
      visit sprangular_engine.root_path
      wait_for_loading
      product = page.all(:css, '.product')[4]
      product.hover
      product.click_link('a')
    end

    scenario 'correct title when displaying a single product' do
      expect(page).to have_title('Ruby on Rails Baseball Jersey - ' + store_name)

      within('h1') do
        expect(page).to have_content('Ruby on Rails Baseball Jersey')
      end
    end

    scenario 'displays metas' do
      expect(page).to have_meta(:description, 'Brand new Ruby on Rails Jersey')
      expect(page).to have_meta(:keywords, 'ror, jersey, ruby')
    end
  end

  scenario "search" do
    visit sprangular_engine.root_path
    wait_for_loading

    within :css, "form[name=SearchForm]" do
      fill_in "keywords", with: "shirt"

      page.find('span.glyphicon').click
    end

    expect(page.all('.product-listing .product').size).to eq(1)
  end

  context "with variants" do
    let(:product) { Spree::Product.find_by_name("Ruby on Rails Baseball Jersey") }
    let(:option_value) { create(:option_value) }
    let!(:variant) { product.variants.create!(price: 5.59) }

    before do
      product.option_types << option_value.option_type
      variant.option_values << option_value
    end

    scenario "displays price of first variant listed" do
      product.variants.first.stock_items.update_all(count_on_hand: 1, backorderable: false)

      visit sprangular_engine.root_path(anchor: "!/products/#{product.slug}")

      click_button "S"

      within(:css, ".add-to-cart .price") do
        expect(page).to have_content(variant.price)
      end
    end

    scenario "display out of stock for when variant sold out" do
      product.variants.first.stock_items.update_all(count_on_hand: 0, backorderable: false)

      visit sprangular_engine.root_path(anchor: "!/products/#{product.slug}")

      click_button "S"

      expect(page).to have_content "This item is sold out"
    end
  end

  context "with variants, images only for the variants" do
    let(:product) { Spree::Product.find_by_name("Ruby on Rails Baseball Jersey") }
    let(:option_type) { create(:option_type) }

    before do
      image = File.open(File.expand_path('../../fixtures/thinking-cat.jpg', __FILE__))

      product.option_types << option_type

      v1 = product.variants.create!(price: 9.99)
      v2 = product.variants.create!(price: 10.99)

      v1.option_values << create(:option_value, presentation: 'S', option_type: option_type)
      v2.option_values << create(:option_value, presentation: 'M', option_type: option_type)

      v1.images.create!(attachment: image)
      v2.images.create!(attachment: image)
    end

    scenario "should not display no image available" do
      visit sprangular_engine.root_path(anchor: "!/products/#{product.slug}")

      click_button "S"

      expect(page).to have_xpath("//img[contains(@src,'thinking-cat')]")
    end
  end

  scenario "hide products without price" do
    Spree::Price.update_all(amount: nil)
    Spree::Config.show_products_without_price = true

    visit sprangular_engine.root_path
    expect(page.all('.product-listing .product').size).to eq(8)

    Spree::Config.show_products_without_price = false

    visit sprangular_engine.root_path
    expect(page.all('.product-listing .product').size).to eq(0)
  end

  scenario "correct title when displaying a single product" do
    product = Spree::Product.find_by_name("Ruby on Rails Baseball Jersey")

    visit sprangular_engine.root_path(anchor: "!/products/#{product.slug}")

    within("h1") do
      expect(page).to have_content("Ruby on Rails Baseball Jersey")
    end
  end
end

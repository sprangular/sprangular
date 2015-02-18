require 'spec_helper'

describe "Cart", type: :feature, js: true do
  let!(:mug) { create(:product, name: "RoR Mug", price: 10.95) }

  before do
    mug.master.stock_items.update_all(count_on_hand: 10)
  end

  scenario "shows cart icon on non-cart pages" do
    visit sprangular_engine.root_path
    expect(page).to have_selector("a.cart-link", visible: true)
  end

  scenario "should increment counter when product added to cart" do
    visit sprangular_engine.root_path(anchor: "!/products/#{mug.slug}")

    expect(page).to have_css("a.cart-link .cart-qty", visible: false)

    expect(page).to have_content("RoR Mug")
    expect(page).to have_content("$10.95")

    page.find(:css, '.add-to-cart').click

    expect(page).to have_css("a.cart-link .cart-qty", text: "1")
  end

  scenario 'allows you to remove an item from the cart' do
    visit sprangular_engine.root_path(anchor: "!/products/#{mug.slug}")

    page.find(:css, '.add-to-cart').click
    page.find(:css, '.cart-link').click
    page.find(:css, '#cart-aside .remove').click

    visit sprangular_engine.root_path(anchor: "!/products/#{mug.slug}")
    page.find(:css, '.add-to-cart').click

    expect(page).to have_content("Your cart is empty")
  end

  scenario 'allows you to update quantity of items in cart' do
    visit sprangular_engine.root_path(anchor: "!/products/#{mug.slug}")

    page.find(:css, '.add-to-cart').click
    page.find(:css, '.cart-link').click

    within :css, "#cart-aside tr.item .quantity-input" do
      page.find(:css, 'a.plus').click
    end

    expect(page).to have_css("a.cart-link .cart-qty", text: "2")
  end

  scenario 'allows you to empty the cart' do
    visit sprangular_engine.root_path(anchor: "!/products/#{mug.slug}")

    page.find(:css, '.add-to-cart').click
    page.find(:css, '.cart-link').click

    within :css, "#cart-aside" do
      page.find(:css, 'a.empty').click
    end

    expect(page).to have_content("Your cart is empty")
    expect(page).to have_css("a.cart-link .cart-qty", visible: false)
  end
end

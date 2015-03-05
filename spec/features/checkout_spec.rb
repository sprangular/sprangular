require 'spec_helper'

describe "Checkout", js: true do
  let!(:user)    { create(:user, email: 'user@example.com', password: '123456') }

  def sign_in
    within 'header' do
      page.find('a', text: 'Sign in').click
    end

    within :css, 'form[name=signinForm]' do
      fill_in "email",    with: "user@example.com"
      fill_in "password", with: "123456"

      click_on "Sign in"
    end
  end

  scenario "add to cart and go to checkout page" do
    product = create(:product, name: "RoR Mug", price: 19.99)
    product.master.stock_items.update_all(count_on_hand: 1)

    visit sprangular_engine.root_path(anchor: "!/products/#{product.slug}")
    wait_for_loading

    page.find(:css, '.add-to-cart').click

    sign_in

    page.find(:css, '.cart-link').click

    within('#cart-aside') do
      page.find(:css, '.checkout-button a').click
    end

    expect(page.find('h1')).to have_content("Checkout")
  end

end

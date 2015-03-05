require 'spec_helper'

describe "Checkout", js: true do
  let!(:country)         { create(:country, states_required: true) }
  let!(:state)           { create(:state, country: country) }
  let!(:shipping_method) { create(:shipping_method) }
  let!(:stock_location)  { create(:stock_location) }
  let!(:product)         { create(:product, name: "RoR Mug", price: 19.99) }
  let!(:payment_method)  { create(:check_payment_method) }
  let!(:zone)            { create(:zone) }
  let!(:user)            { create(:user, email: 'user@example.com', password: '123456') }

  before do
    product.master.stock_items.update_all(count_on_hand: 1)
  end

  scenario "add to cart and go to checkout page" do
    add_mug_to_cart
    checkout

    expect(page.find('h1')).to have_content("Checkout")
  end

  scenario "checkout new address and new credit card" do
    add_mug_to_cart
    checkout

    within "#billing-address" do
      fill_in "first-name", with: "John"
      fill_in "last-name",  with: "Smith"
      fill_in "address",    with: "123 Main St."
      fill_in "city",       with: "Montgomery"

      select "United States of America", from: "country"
      select "Alabama",                  from: "state"

      fill_in "zip",   with: "12345"
      fill_in "phone", with: "1231231234"
    end

    fill_in "number", with: "4111111111111111"
    select "6 - June",        from: "month"
    select Date.today.year+1, from: "year"
    fill_in "cvc", with: "123"

    page.find(:css, "#confirm").click
    expect(page.find('h1')).to have_content("Confirm")

    page.find(:css, "#complete").click

    sleep(0.1) while page.evaluate_script("document.querySelector('.loading')")

    expect(page.find('h1')).to have_content("Order Submitted")
  end

  def checkout
    sleep 2
    page.find(:css, '.cart-link').click

    within('#cart-aside') do
      page.find(:css, '.checkout-button a').click
    end

    within :css, 'form[name=signinForm]' do
      fill_in "email",    with: "user@example.com"
      fill_in "password", with: "123456"

      click_on "Sign in"
    end
  end

  def add_mug_to_cart
    visit sprangular_engine.root_path(anchor: "!/products/#{product.slug}")
    wait_for_loading

    page.find(:css, '.add-to-cart').click
  end
end

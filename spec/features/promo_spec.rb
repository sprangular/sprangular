require 'spec_helper'

describe "Promo", js: true do
  let!(:product) { create(:product, name: "RoR Mug", price: 19.99) }

  let!(:promotion) do
    promotion = Spree::Promotion.create!(name: "$10 Off",
                                         code: '10off',
                                         path: '10off',
                                         starts_at: 1.day.ago,
                                         expires_at: 1.day.from_now)


    calculator = Spree::Calculator::FlatRate.new
    calculator.preferred_amount = 10

    action = Spree::Promotion::Actions::CreateItemAdjustments.create(calculator: calculator)
    promotion.actions << action
    promotion.reload # so that promotion.actions is available
  end

  before do
    product.master.stock_items.update_all(count_on_hand: 1)

    visit sprangular_engine.root_path(anchor: "!/products/#{product.slug}")

    page.find(:css, '.add-to-cart').click
    page.find(:css, '.cart-link').click
  end

  def add_coupon(code)
    page.find('a', text: 'Add Coupon').click

    within :css, "form[name=PromoForm]" do
      fill_in "promo-code", with: code

      click_on "Save"
    end

    while page.evaluate_script("document.querySelector('.loading')")
      sleep 0.1
    end
  end

  scenario "adding a coupon code" do
    add_coupon("10off")

    total = page.find(:css, '.total .number')
    expect(total.text).to eq('$9.99')
  end

  scenario "adding coupon twice shows error" do
    add_coupon("10off")
    add_coupon("10off")

    expect(page).to have_content("The coupon code has already been applied")
  end

  scenario "adding an invalid coupon code" do
    add_coupon("ALL-FREE")

    expect(page).to have_content("The coupon code you entered doesn't exist")
  end
end

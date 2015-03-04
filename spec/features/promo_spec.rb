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
  end

  scenario "adding a coupon code" do
    visit sprangular_engine.root_path(anchor: "!/products/#{product.slug}")

    page.find(:css, '.add-to-cart').click
    page.find(:css, '.cart-link').click

    total = page.find(:css, '.total .number')
    expect(total.text).to eq('$19.99')

    page.find('a', text: 'Add Coupon').click

    within :css, "form[name=PromoForm]" do
      fill_in "promo-code", with: "10off"

      click_on "Save"
    end

    total = page.find(:css, '.total .number')
    expect(total.text).to eq('$9.99')
  end
end

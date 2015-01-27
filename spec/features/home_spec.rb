require 'spec_helper'

describe "Home Page", js: true do
  scenario "shows welcome message" do
    visit sprangular_engine.root_path
    expect(page).to have_content("Welcome to Sprangular!")
  end
end

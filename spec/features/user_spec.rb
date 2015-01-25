require 'spec_helper'

describe "User", type: :feature, js: true do
  it "can sign in and sign out" do
    user = create(:user, email: 'user@example.com', password: '123456', password_confirmation: '123456')

    visit sprangular_engine.root_path

    within 'header' do
      page.find('a', text: 'Sign in').click
    end

    within :css, 'form[name=signinForm]' do
      fill_in "email",    with: "user@example.com"
      fill_in "password", with: "123456"

      click_on "Sign in"
    end

    within "header" do
      expect(page).to have_content("Log out")
      expect(page).to_not have_content("Sign in")
    end

    expect(page).to have_text("Welcome to Sprangular")

    within 'header' do
      page.find('a', text: 'Log out').click
    end

    within "header" do
      expect(page).to_not have_content("Log out")
      expect(page).to have_content("Sign in")
    end

    expect(page).to have_text("Welcome to Sprangular")
  end

  it "can sign up" do
    visit sprangular_engine.root_path

    within 'header' do
      page.find('a', text: 'Sign in').click
    end

    page.find('a', text: 'Create account').click

    within :css, 'form[name=signupForm]' do
      fill_in "email",                 with: "user@example.com"
      fill_in "password",              with: "123456"
      fill_in "password-confirmation", with: "123456"

      click_on "Sign up"
    end

    within "header" do
      expect(page).to have_content("Log out")
      expect(page).to_not have_content("Sign in")
    end

    expect(page).to have_text("Welcome to Sprangular")
  end

  it "is redirected to requested page after sign in" do
    user = create(:user, email: 'user@example.com', password: '123456', password_confirmation: '123456')

    visit sprangular_engine.root_path

    within 'header' do
      page.find('a', text: 'My Account').click
    end

    within :css, 'form[name=signinForm]' do
      fill_in "email",    with: "user@example.com"
      fill_in "password", with: "123456"

      click_on "Sign in"
    end

    within 'h1' do
      expect(page).to have_text("My Account")
    end
  end

  it "is redirected to requested page after sign up" do
    visit sprangular_engine.root_path

    within 'header' do
      page.find('a', text: 'My Account').click
    end

    page.find('a', text: 'Create account').click

    within :css, 'form[name=signupForm]' do
      fill_in "email",                 with: "user@example.com"
      fill_in "password",              with: "123456"
      fill_in "password-confirmation", with: "123456"

      click_on "Sign up"
    end

    within 'h1' do
      expect(page).to have_text("My Account")
    end
  end
end

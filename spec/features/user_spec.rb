require 'spec_helper'

describe "User", js: true do
  scenario "sign in and sign out" do
    user = create(:user, email: 'user@example.com', password: '123456', password_confirmation: '123456')

    visit sprangular_engine.root_path
    wait_for_route_changes

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

  scenario "sign up" do
    visit sprangular_engine.root_path
    wait_for_route_changes

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

  scenario "redirected to requested page after sign in" do
    user = create(:user, email: 'user@example.com', password: '123456', password_confirmation: '123456')

    visit sprangular_engine.root_path
    wait_for_route_changes

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

  scenario "redirected to requested page after sign up" do
    visit sprangular_engine.root_path
    wait_for_route_changes

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

  scenario "reset password" do
    create(:store, url: 'example.com')
    user = create(:user, email: 'user@example.com', password: '123456', password_confirmation: '123456')

    visit sprangular_engine.root_path
    wait_for_route_changes

    within 'header' do
      page.find('a', text: 'Sign in').click
    end

    page.find('a', text: 'Forgot your password?').click

    within :css, "form[name=ForgotPasswordForm]" do
      fill_in "email", with: "user@example.com"

      click_on "Reset my password"
    end

    page.find('a', text: 'Shop').click
    page.find('a', text: 'All Products').click

    user = user.reload
    raw_token = user.send_reset_password_instructions

    visit sprangular_engine.root_path(anchor: "!/reset-password/#{raw_token}")
    wait_for_route_changes

    within :css, "form[name=ResetPasswordForm]" do
      fill_in "password",              with: "654321"
      fill_in "password_confirmation", with: "654321"

      click_on "Update my password"
    end

    expect(page).to have_text("Welcome to Sprangular")

    within "header" do
      expect(page).to have_content("Log out")
      expect(page).to_not have_content("Sign in")
    end
  end
end

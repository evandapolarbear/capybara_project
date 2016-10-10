require 'spec_helper'
require 'rails_helper'

feature "the signup process" do
  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New User"
  end

  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      fill_in 'Username', :with => 'bob'
      fill_in 'Password', :with => 'bob123'
      click_on "Create User"
    end

    scenario "shows username on the homepage after signup" do
      expect(page).to have_content "bob"
    end
  end
end

feature "logging in" do

  scenario "has a Log In page" do
    visit new_session_url
    expect(page).to have_content "Sign In"
  end


  feature "Log In" do
    bob = FactoryGirl.build(:user, username: 'bob2', password: 'bob123')
    before(:each) do
      visit new_session_url
      fill_in 'Username', :with => 'bob2'
      fill_in 'Password', :with => 'bob123'
      click_on 'Log In'
    end
    scenario "shows username on the homepage after login" do
      expect(page).to have_content 'bob'
    end
  end
end

feature "logging out" do
  bob = FactoryGirl.build(:user, username: 'bob2', password: 'bob123')

  before(:each) do
    visit new_session_url
    fill_in 'Username', :with => 'bob2'
    fill_in 'Password', :with => 'bob123'
    click_on 'Log In'
  end
  scenario "begins with a logged out state" do
    visit new_session_url
    expect(page).to_not have_content "Sign Out"
    # expect(page).to have_content "Sign In"
  end

  scenario "doesn't show username on the homepage after logout" do
      click_on 'Sign Out'
      expect(page).to_not have_content('bob2')
  end
end

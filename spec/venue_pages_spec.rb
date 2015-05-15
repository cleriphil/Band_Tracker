require('spec_helper')
Capybara.app = Sinatra::Application

describe('path to add and view venues', {:type => :feature}) do
  it('allows the user to add and view a venue') do
    visit('/')
    click_link('View Venues')
    click_link('Add a Venue')
    fill_in('name', :with => 'The Cement Theatre')
    fill_in('city', :with => 'Denver, CO')
    click_button('Submit')
    expect(page).to have_content('The Cement Theatre')
  end
end

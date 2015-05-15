require('spec_helper')
Capybara.app = Sinatra::Application

describe('the path to add and view bands', {:type => :feature}) do
  it('allows the user to add a band') do
    visit('/')
    click_link('View Bands')
    click_link('Add a Band')
    fill_in('name', :with => 'Purple')
    fill_in('genre', :with => 'Folk')
    click_button('Submit')
    expect(page).to have_content('Purple')
  end

  it('allows the user to add multiple bands and view them') do
    visit('/')
    click_link('View Bands')
    click_link('Add a Band')
    fill_in('name', :with => 'Purple')
    fill_in('genre', :with => 'Folk')
    click_button('Submit')
    click_link('Add a Band')
    fill_in('name', :with => 'Orange')
    fill_in('genre', :with => 'Rock')
    click_button('Submit')
    expect(page).to have_content('Purple')
    expect(page).to have_content('Orange')
  end

  it('allows the user to view an individual band and to select its venues') do
    visit('/')
    click_link('View Venues')
    click_link('Add a Venue')
    fill_in('name', :with => 'Theatre')
    fill_in('city', :with => 'Denver, CO')
    click_button('Submit')
    click_link('Add a Venue')
    fill_in('name', :with => 'Theatre2')
    fill_in('city', :with => 'Springfield, MA')
    click_button('Submit')

    visit('/')
    click_link('View Bands')
    click_link('Add a Band')
    fill_in('name', :with => 'Purple')
    fill_in('genre', :with => 'Folk')
    click_button('Submit')
    click_link('Purple')
    select('Theatre')
    click_button('Submit')
    select('Theatre2')
    click_button('Submit')
    expect(page).to have_content('Theatre')
    expect(page).to have_content('Theatre2')

  end

end

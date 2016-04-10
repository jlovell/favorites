require 'rails_helper'

RSpec.describe 'creating a new restaurant', driver: :webkit do

  def restaurant_list
    find('#restaurants-filtered')
  end

  it 'creates a new restaurant that then shows up on the homepage' do
    visit root_path
    fill_in 'search-filter', with: 'Cool New Cafe'
    expect(restaurant_list).not_to have_content 'Cool New Cafe'

    click_on 'add-new-place'
    expect(page).to have_content 'Successfully created'

    visit root_path
    fill_in 'search-filter', with: 'Cool New Cafe'
    expect(restaurant_list).to have_content 'Cool New Cafe'
  end

end

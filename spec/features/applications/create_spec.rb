require 'rails_helper'

RSpec.describe 'create application' do
  describe 'new application' do
    it 'renders the new form' do
      visit '/pets'

      click_link 'Start an Application'

      expect(current_path).to eq('/applications/new')
      # expect(page).to have_content('New Application')
      # expect(page).to have_content('Name')
      # expect(page).to have_content("Street Address ")
      # expect(page).to have_content('City')
      # expect(page).to have_content('State')
      # expect(page).to have_content('Zip Code')
      # expect(page).to have_content('Description')
    end
  end

  describe 'create application' do
    context 'given valid data' do
      it 'creates a new application' do
        visit '/pets'

        click_link 'Start an Application'

        fill_in 'Name', with: 'Joe J'
        fill_in 'Street Address', with: '100 Longhorn Lane'
        fill_in 'City', with: 'Houston'
        fill_in 'State', with: 'Texas'
        fill_in 'Zip Code', with: 12345
        fill_in 'Description', with: "Big yard and loving family"

        click_button('Save')

        expect(page).to have_current_path("/applications/#{Application.last.id}")
        expect(page).to have_content('Joe J')
    end

    end
  end
end

require 'rails_helper'

RSpec.describe 'create application' do
  describe 'new application' do
    it 'renders the new form' do
      visit '/applications/new'

      expect(page).to have_content('New Application')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Street address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zip code')
      expect(find('form')).to have_content('Description')
    end
  end

  describe 'create application' do
    context 'given valid data' do
      it 'creates a new application' do
        visit '/applications/new'

        fill_in 'Name', with: 'Joe J'
        fill_in 'Street address', with: '100 Longhorn Lane'
        fill_in 'City', with: 'Houston'
        fill_in 'State', with: 'Texas'
        fill_in 'Zip code', with: 12345
        fill_in 'Description', with: "Big yard and loving family"

        click_button('Save')

        expect(page).to have_current_path("/applications/#{Application.last.id}")
        expect(page).to have_content('Joe J')
    end

    end
  end
end

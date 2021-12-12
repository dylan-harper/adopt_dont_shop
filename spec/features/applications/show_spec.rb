require 'rails_helper'

RSpec.describe 'application show' do
  before :each do
    @application = Application.create!(name: 'Bill Jones',
                                       description: 'Loving Family',
                                       status: 'pending'
    )
    @address = @application.create_address(street_address: '100 Longhorn Way',
                                 city: 'Ojai',
                                 state: 'CA',
                                 zip_code: 78945
    )
  end
  it 'exists' do
    expect(@application).to be_an_instance_of(Application)
    expect(@address).to be_an_instance_of(Address)
  end

  it 'dipslays the applicant name' do
    visit "/applications/#{@application.id}"

    expect(page).to have_content(@application.name)
  end
end

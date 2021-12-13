require 'rails_helper'

RSpec.describe 'application show' do
  before :each do
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)

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

  it 'can search a pet name' do
    visit "/applications/#{@application.id}"

    expect(page).to have_content("Add a Pet to this Application")

    fill_in :search, with: "Lucille Bald"
    click_button('Search')

    expect(current_path).to eq("/applications/#{@application.id}")
    expect(page).to have_content('Bill Jones')
    expect(page).to have_content('Lucille Bald')
  end

  xit 'can add a pet to the application' do
    visit "/applications/#{@application.id}"

    expect(page).to have_content("Add a Pet to this Application")

    fill_in :search, with: "Lucille Bald"
    click_button('Search')
    click_button 'Adopt this Pet'
  end
end
# <button><%= link_to 'Adopt this Pet',  "/applications/#{@application.id}?query=#{pet.id}", method: :get %></button>
# <h3>Pets chosen for application: </h3>
# <% @chosen_pets.each do |pet| %>
#   <p><%= pet.name %></p>
# <% end %>

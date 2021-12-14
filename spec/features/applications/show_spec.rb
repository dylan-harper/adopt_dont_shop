require 'rails_helper'

RSpec.describe 'application show' do
  before :each do
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @pet_3 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bad', shelter_id: @shelter.id)
    @pet_4 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Baddest', shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)

    @application = Application.create!(name: 'Bill Jones',
                                       description: 'Loving Family',
                                       status: 'In Progress'
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

  it 'can add a pet to the application' do
    visit "/applications/#{@application.id}"

    expect(page).to have_content("Add a Pet to this Application")

    fill_in :search, with: "Lucille Bald"
    click_button('Search')
    click_button 'Adopt this Pet'

    fill_in :search, with: "Lobster"
    click_button('Search')
    click_button 'Adopt this Pet'

    expect(page).to have_content("Lucille Bald")
    expect(page).to have_content("Lobster")
    expect(page).to have_content("#{@application.status}, Lucille Bald")
    expect(page).to have_content("#{@application.status}, Lobster")
  end

  it 'can submit the application' do
    visit "/applications/#{@application.id}"

    fill_in :search, with: "Lucille Bald"
    click_button('Search')
    click_button 'Adopt this Pet'

    fill_in :search, with: "Lobster"
    click_button('Search')
    click_button 'Adopt this Pet'

    fill_in :description, with: "Big yard"

    click_button 'Submit Application'

    expect(current_path).to eq("/applications/#{@application.id}")
    expect(page).to have_content("Big yard")
    expect(page).to have_content("Pending")
    expect(page).to_not have_content("Add a Pet to this Application")
  end

  it 'can handle partial searches/matches' do
    visit "/applications/#{@application.id}"

    fill_in :search, with: "luCilLE b"
    click_button('Search')

    expect(page).to have_content("Lucille Bald")
    expect(page).to have_content("Lucille Bad")
    expect(page).to have_content("Lucille Baddest")
  end
end

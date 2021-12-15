require 'rails_helper'

RSpec.describe 'the shelters index' do
  before(:each) do
    @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @pet_1 = @shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

    @application_1 = @pet_1.applications.create!(name: 'Bill Jones',
                                       description: 'Loving Family',
                                       status: 'In Progress'
    )
    @application_2 = @pet_2.applications.create!(name: 'Jill Jones',
                                       description: 'Loving Family',
                                       status: 'Pending'
    )
    @application_3 = @pet_3.applications.create!(name: 'Gill Jones',
                                       description: 'Loving Family',
                                       status: 'Pending'
    )
    @address_1 = @application_1.create_address(street_address: '100 Longhorn Way',
                                 city: 'Ojai',
                                 state: 'CA',
                                 zip_code: 78945
    )
    @address_2 = @application_2.create_address(street_address: '100 Longhorn Way',
                                 city: 'Ojai',
                                 state: 'CA',
                                 zip_code: 78945
    )
    @address_3 = @application_3.create_address(street_address: '100 Longhorn Way',
                                 city: 'Ojai',
                                 state: 'CA',
                                 zip_code: 78945
    )
  end

  it 'lists all the shelter names' do
    visit "/shelters"

    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
    expect(page).to have_content(@shelter_3.name)
  end

  # it 'lists the shelters by most recently created first' do
  #   visit "/shelters"
  #
  #   oldest = find("#shelter-#{@shelter_1.id}")
  #   mid = find("#shelter-#{@shelter_2.id}")
  #   newest = find("#shelter-#{@shelter_3.id}")
  #
  #   expect(newest).to appear_before(mid)
  #   expect(mid).to appear_before(oldest)
  #
  #   within "#shelter-#{@shelter_1.id}" do
  #     expect(page).to have_content("Created at: #{@shelter_1.created_at}")
  #   end

#   within "#shelter-#{@shelter_2.id}" do
#     expect(page).to have_content("Created at: #{@shelter_2.created_at}")
#   end
#
#   within "#shelter-#{@shelter_3.id}" do
#     expect(page).to have_content("Created at: #{@shelter_3.created_at}")
#   end
# end
  it 'lists the shelters by reverse alphabetical order' do
    visit "/shelters"

    expect(@shelter_2.name).to appear_before(@shelter_3.name)
    expect(@shelter_3.name).to appear_before(@shelter_1.name)
  end

  it 'has a link to sort shelters by the number of pets they have' do
    visit '/shelters'

    expect(page).to have_link("Sort by number of pets")
    click_link("Sort by number of pets")

    expect(page).to have_current_path('/shelters?sort=pet_count')
    # expect(@shelter_1.name).to appear_before(@shelter_3.name)
    # expect(@shelter_3.name).to appear_before(@shelter_2.name)
  end

  it 'has a link to update each shelter' do
    visit "/shelters"

    within "#shelter-#{@shelter_1.id}" do
      expect(page).to have_link("Update #{@shelter_1.name}")
    end

    within "#shelter-#{@shelter_2.id}" do
      expect(page).to have_link("Update #{@shelter_2.name}")
    end

    within "#shelter-#{@shelter_3.id}" do
      expect(page).to have_link("Update #{@shelter_3.name}")
    end

    click_on("Update #{@shelter_1.name}")
    expect(page).to have_current_path("/shelters/#{@shelter_1.id}/edit")
  end

  it 'has a link to delete each shelter' do
    visit "/shelters"

    within "#shelter-#{@shelter_1.id}" do
      expect(page).to have_link("Delete #{@shelter_1.name}")
    end

    within "#shelter-#{@shelter_2.id}" do
      expect(page).to have_link("Delete #{@shelter_2.name}")
    end

    within "#shelter-#{@shelter_3.id}" do
      expect(page).to have_link("Delete #{@shelter_3.name}")
    end

    click_on("Delete #{@shelter_1.name}")
    expect(page).to have_current_path("/shelters")
    expect(page).to_not have_content(@shelter_1.name)
  end

  it 'has a text box to filter results by keyword' do
    visit "/admin/shelters"
    expect(page).to have_button("Search")
  end

  it 'lists partial matches as search results' do
    visit "/shelters"

    fill_in 'Search', with: "RGV"
    click_on("Search")

    expect(page).to have_content(@shelter_2.name)
    # expect(page).to_not have_content(@shelter_1.name)
  end

  it 'lists shelters with pending applications' do
    visit "/admin/shelters"

    expect(page).to have_content("Shelters with Pending Applications")

    within "#pending-app-#{@shelter_1.id}" do
      expect(page).to have_content(@shelter_1.name)
    end

  end
end

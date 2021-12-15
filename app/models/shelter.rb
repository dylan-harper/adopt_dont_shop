class Shelter < ApplicationRecord
  validates :name, presence: true
  validates :rank, presence: true, numericality: true
  validates :city, presence: true

  has_many :pets, dependent: :destroy

  def self.order_by_recently_created
    order(created_at: :desc)
  end

  def self.with_pending_apps
    shelters = Shelter.all
    pending = []
    shelters.each do |shelter|
      shelter.pets.each do |pet|
        pet.applications.each do |app|
          if app.status == 'Pending'
            pending << shelter
          end
        end
      end
    end
    pending = pending.uniq
  end

  def self.order_by_reverse_alphabetical
    select("shelters.*")
      .order("name DESC")
  end

  def self.order_by_number_of_pets
    select("shelters.*, count(pets.id) AS pets_count")
      .joins("LEFT OUTER JOIN pets ON pets.shelter_id = shelters.id")
      .group("shelters.id")
      .order("pets_count DESC")
  end

  def pet_count
    pets.count
  end

  def adoptable_pets
    pets.where(adoptable: true)
  end

  def alphabetical_pets
    adoptable_pets.order(name: :asc)
  end

  def shelter_pets_filtered_by_age(age_filter)
    adoptable_pets.where('age >= ?', age_filter)
  end
end

class Address < ApplicationRecord
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  belongs_to :application
end

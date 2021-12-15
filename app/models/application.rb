class Application <  ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :status, presence: true
  has_one :address, dependent: :destroy
  has_many :application_pets
  has_many :pets, through: :application_pets


  def edit_status(params)
    self.write_attribute(:description, params[:description])
    self.write_attribute(:status, "Pending")
  end
end

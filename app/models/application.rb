class Application <  ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :status, presence: true
  has_one :address, dependent: :destroy

end

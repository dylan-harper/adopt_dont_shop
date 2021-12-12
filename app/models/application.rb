class Application <  ApplicationRecord

  has_one :address, dependent: :destroy

end

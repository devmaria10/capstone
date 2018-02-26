class UserMedication < ApplicationRecord
  belongs_to :user 
  belongs_to :diagnosis, optional: true
  belongs_to :medication
  belongs_to :provider, optional: true
  has_one :timer, as: :timerable
end

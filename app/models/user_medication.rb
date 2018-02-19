class UserMedication < ApplicationRecord
  belongs_to :user 
  belongs_to :diagnosis, optional: true
  belongs_to :medications
  belongs_to :providers, optional: true
  has_one :timer, as: :timerable
end

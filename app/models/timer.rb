class Timer < ApplicationRecord
  belongs_to :provider, optional: true
  belongs_to :timerable, polymorphic: true
  has_one :user, through: :timerable
end
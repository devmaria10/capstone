class Timer < ApplicationRecord
  belongs_to :provider, optional: true
  belongs_to :timerable, polymorphic: true
end
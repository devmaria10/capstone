class Timer < ApplicationRecord
  belongs_to :provider
  belongs_to :timerable, polymorphic: true
end
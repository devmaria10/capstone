class Timer < ApplicationRecord
  belongs_to :providers
  belongs_to :usermedications
  belongs_to :timerable, polymorphic: true
end
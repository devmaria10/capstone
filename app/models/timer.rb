class Timer < ApplicationRecord
  belongs_to :providers
  has_many :usermedications
  belongs_to :timerable, polymorphic: true
end
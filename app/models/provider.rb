class Provider < ApplicationRecord
  has_many :user_providers
  has_many :users, through: :user_providers
  has_many :timers, as: :timerable
end

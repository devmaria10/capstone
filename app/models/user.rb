class User < ApplicationRecord
  has_many :user_providers
  has_many :providers, through: :user_providers

  has_many :user_medications
  has_many :medications, through: :user_medications
  has_many :diagnosis, through: :user_medications

end

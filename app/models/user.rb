class User < ApplicationRecord
  has_secure_password
  has_many :user_providers
  has_many :providers, through: :user_providers

  has_many :user_medications
  has_many :medications, through: :user_medications
  has_many :diagnosis, through: :user_medications

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true


  #User.user_medications.each do |user_medication|
  #  user_medication.dosage 
  #  user_medication.doctor_id 
  #end
end

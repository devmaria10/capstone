class User < ApplicationRecord
  has_many :user_providers
  has_many :providers, through: :user_providers

  has_many :user_medications
  has_many :medications, through: :user_medications
  has_many :diagnosis, through: :user_medications


  #User.user_medications.each do |user_medication|
  #  user_medication.dosage 
  #  user_medication.doctor_id 
  #end
end

class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  
  has_many :user_providers
  has_many :providers, through: :user_providers
  has_many :provider_timers, through: :providers, source: :timers

  has_many :user_medications
  has_many :medication_timers, through: :user_medications, source: :timers

  has_many :medications, through: :user_medications
  has_many :diagnosis, through: :user_medications
  
  def timers
    provider_timers + medication_timers
  end

  #User.user_medications.each do |user_medication|
  #  user_medication.dosage 
  #  user_medication.doctor_id 
  #end
end

class ChangeDoctorToProviderOnUserMedications < ActiveRecord::Migration[5.1]
  def change
    rename_column :user_medications, :doctor_id, :provider_id
  end
end

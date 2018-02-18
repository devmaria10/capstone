class CreateUserMedications < ActiveRecord::Migration[5.1]
  def change
    create_table :user_medications do |t|
      t.integer :diagnosis_id
      t.integer :medication_id
      t.integer :user_id
      t.string :dosage
      t.integer :doctor_id

      t.timestamps
    end
  end
end

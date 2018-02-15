class CreateDiagnoses < ActiveRecord::Migration[5.1]
  def change
    create_table :diagnoses do |t|
      t.string :name
      t.string :icd_10_code

      t.timestamps
    end
  end
end

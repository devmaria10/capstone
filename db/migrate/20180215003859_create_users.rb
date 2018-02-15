class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :dob
      t.string :street_address
      t.string :city
      t.string :state
      t.integer :zip
      t.string :phone_number
      t.string :email

      t.timestamps
    end
  end
end

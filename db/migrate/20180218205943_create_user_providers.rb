class CreateUserProviders < ActiveRecord::Migration[5.1]
  def change
    create_table :user_providers do |t|
      t.integer :user_id
      t.integer :provider_id

      t.timestamps
    end
  end
end

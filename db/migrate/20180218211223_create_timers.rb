class CreateTimers < ActiveRecord::Migration[5.1]
  def change
    create_table :timers do |t|
      t.string :last_rang
      t.integer :increment
      t.integer :timerable_id
      t.string :timerable_type

      t.timestamps
    end
  end
end

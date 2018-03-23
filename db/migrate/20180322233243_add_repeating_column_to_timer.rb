class AddRepeatingColumnToTimer < ActiveRecord::Migration[5.1]
  def change
    add_column :timers, :repeating, :boolean
  end
end

class ChangeRepeatingColumnOnTimer < ActiveRecord::Migration[5.1]
  def change
    change_column :timers, :repeating, :boolean, default: false
  end
end

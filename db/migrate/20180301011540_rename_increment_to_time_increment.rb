class RenameIncrementToTimeIncrement < ActiveRecord::Migration[5.1]
  def change
    rename_column :timers, :increment, :time_increment
  end
end

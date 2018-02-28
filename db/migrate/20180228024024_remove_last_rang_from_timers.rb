class RemoveLastRangFromTimers < ActiveRecord::Migration[5.1]
  def change
    remove_column :timers, :last_rang, :string
  end
end

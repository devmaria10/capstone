class AddLastRangBackToTimers < ActiveRecord::Migration[5.1]
  def change
    add_column :timers, :last_rang, :datetime
  end
end

class ChangeIncrementToInteger < ActiveRecord::Migration[5.1]
  def change
    change_column :timers, :increment, :integer
  end
end

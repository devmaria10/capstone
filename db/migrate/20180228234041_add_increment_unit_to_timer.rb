class AddIncrementUnitToTimer < ActiveRecord::Migration[5.1]
  def change
    add_column :timers, :increment_unit, :string
  end
end

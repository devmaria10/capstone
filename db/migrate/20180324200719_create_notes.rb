class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.datetime :date
      t.text :note

      t.timestamps
    end
  end
end

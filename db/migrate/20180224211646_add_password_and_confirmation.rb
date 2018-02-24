class AddPasswordAndConfirmation < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :password, :string
    add_column :users, :passwordconfirmation, :string
  end
end

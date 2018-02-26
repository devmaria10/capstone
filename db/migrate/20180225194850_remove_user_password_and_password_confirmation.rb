class RemoveUserPasswordAndPasswordConfirmation < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :password, :string
    remove_column :users, :passwordconfirmation, :string
  end
end

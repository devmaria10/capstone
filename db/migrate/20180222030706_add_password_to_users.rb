class AddPasswordToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :password, :string
    add_column :users, :passworddigest, :string 
  end
end
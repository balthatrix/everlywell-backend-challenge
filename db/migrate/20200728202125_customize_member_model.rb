class CustomizeMemberModel < ActiveRecord::Migration[6.0]
  def change
    remove_column :members, :email, :string
    add_column :members, :name, :string
  end
end

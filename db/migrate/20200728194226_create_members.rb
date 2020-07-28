class CreateMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :members do |t|
      t.string :email
      t.string :password_digest
      t.string :website_address
      t.string :website_short_address

      t.timestamps
    end
  end
end

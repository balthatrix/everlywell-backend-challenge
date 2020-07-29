class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.references :member_a, null: false, index: true, foreign_key: {to_table: :members}
      t.references :member_b, null: false, index: true, foreign_key: {to_table: :members}

      t.timestamps
    end
  end
end

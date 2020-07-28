class CreateMemberTopics < ActiveRecord::Migration[6.0]
  def change
    create_table :member_topics do |t|
      t.references :member
      t.references :topic

      t.timestamps
    end
  end
end

class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.integer :community_id
      t.integer :customer_id
      t.text :reply
      t.timestamps
    end
  end
end

class CreateBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmarks do |t|
      t.integer :community_id
      t.integer :customer_id
      t.timestamps
    end
  end
end

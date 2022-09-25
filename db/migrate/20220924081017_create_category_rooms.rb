class CreateCategoryRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :category_rooms do |t|
      t.integer :category_id
      t.integer :room_id
      t.timestamps
    end
  end
end

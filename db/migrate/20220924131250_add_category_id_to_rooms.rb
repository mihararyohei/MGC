class AddCategoryIdToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :category_id, :string
  end
end

class AddCustomerRefAndRoomRefToMessages < ActiveRecord::Migration[6.1]
  def change
    add_reference :messages, :customer, null: false, foreign_key: true
    add_reference :messages, :room, null: false, foreign_key: true
    change_column_null :messages, :customer_id, false
    change_column_null :messages, :room_id, false
  end
end

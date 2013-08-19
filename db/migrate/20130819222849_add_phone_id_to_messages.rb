class AddPhoneIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :phone_id, :integer
    add_index :messages, :phone_id
  end
end

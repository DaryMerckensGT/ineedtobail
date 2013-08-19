class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :user, index: true
      t.datetime :send_at
      t.text :text
      t.string :type

      t.timestamps
    end
  end
end

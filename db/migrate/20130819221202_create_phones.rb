class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.references :user, index: true
      t.string :number
      t.integer :confirmation_code
      t.integer :confirmation_tries, default: 0

      t.timestamps
    end
  end
end

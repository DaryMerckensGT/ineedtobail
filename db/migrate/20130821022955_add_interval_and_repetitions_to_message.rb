class AddIntervalAndRepetitionsToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :interval, :integer, default: nil
    add_column :messages, :repititions, :integer, default: nil
  end
end

class AddColumnToEvent < ActiveRecord::Migration[5.1]
  def change
    add_reference :events, :user, foreign_key: true
    add_index :events, [:user_id, :created_at]
  end
end

class CreatePlans < ActiveRecord::Migration[5.1]
  def change
    create_table :plans do |t|
      t.string :title
      t.references :user, foreign_key: true
      t.text :description
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
    add_index :plans, [:user_id, :created_at]
  end
end

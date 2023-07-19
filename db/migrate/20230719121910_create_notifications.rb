class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.datetime :date
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end

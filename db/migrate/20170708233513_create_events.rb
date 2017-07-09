class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :chronic_string
      t.references :calender, foreign_key: true

      t.timestamps
    end
  end
end

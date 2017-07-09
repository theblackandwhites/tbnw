class CreateEventItems < ActiveRecord::Migration[5.0]
  def change
    create_table :event_items do |t|
      t.string :title
      t.text :description
      t.boolean :training
      t.boolean :support
      t.string :color_hex

      t.timestamps
    end
  end
end

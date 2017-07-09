class AddIconToEventItems < ActiveRecord::Migration[5.0]
  def change
    add_column :event_items, :icon, :string
  end
end

class AddReferenceToEvents < ActiveRecord::Migration[5.0]
  def change
    add_reference :events, :event_item, foreign_key: true
  end
end

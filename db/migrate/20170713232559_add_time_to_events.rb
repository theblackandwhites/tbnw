class AddTimeToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :time, :string
    add_column :events, :description, :text
  end
end

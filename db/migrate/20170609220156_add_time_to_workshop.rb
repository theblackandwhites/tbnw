class AddTimeToWorkshop < ActiveRecord::Migration[5.0]
  def change
    add_column :workshops, :start_hour, :number
    add_column :workshops, :start_minute, :number
    add_column :workshops, :start_second, :number
  end
end

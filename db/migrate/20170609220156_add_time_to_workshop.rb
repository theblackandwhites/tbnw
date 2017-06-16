class AddTimeToWorkshop < ActiveRecord::Migration[5.0]
  def change
    add_column :workshops, :start_hour, :integer
    add_column :workshops, :start_minute, :integer
    add_column :workshops, :start_second, :integer
  end
end

class AddDateToWorkshops < ActiveRecord::Migration[5.0]
  def change
    add_column :workshops, :start_date, :date
  end
end

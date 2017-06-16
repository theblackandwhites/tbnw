class AddStatusToWorkshop < ActiveRecord::Migration[5.0]
  def change
    add_column :workshops, :status_closed, :boolean
  end
end

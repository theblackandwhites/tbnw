class CreateWorkshops < ActiveRecord::Migration[5.0]
  def change
    create_table :workshops do |t|
      t.string :start_time
      t.string :finish_time

      t.timestamps
    end
  end
end

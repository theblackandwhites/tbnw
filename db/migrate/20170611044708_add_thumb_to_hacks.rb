class AddThumbToHacks < ActiveRecord::Migration[5.0]
  def change
    add_column :hacks, :thumb, :text
  end
end

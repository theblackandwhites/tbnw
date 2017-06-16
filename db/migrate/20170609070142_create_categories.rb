class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :title
      t.string :color_hex
      t.string :icon_code

      t.timestamps
    end
  end
end

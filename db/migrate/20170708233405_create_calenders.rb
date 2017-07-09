class CreateCalenders < ActiveRecord::Migration[5.0]
  def change
    create_table :calenders do |t|
      t.string :month
      t.text :intro

      t.timestamps
    end
  end
end

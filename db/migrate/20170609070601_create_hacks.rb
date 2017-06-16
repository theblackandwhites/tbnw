class CreateHacks < ActiveRecord::Migration[5.0]
  def change
    create_table :hacks do |t|
      t.string :video_embed_code
      t.boolean :members_only
      t.string :title
      t.text :description
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end

class AddEmbedFeildsToWorkshops < ActiveRecord::Migration[5.0]
  def change
    add_column :workshops, :widget_embed, :text
    add_column :workshops, :webinar_embed, :text
  end
end

class AddLinkToHacks < ActiveRecord::Migration[5.0]
  def change
    add_column :hacks, :links, :text
  end
end

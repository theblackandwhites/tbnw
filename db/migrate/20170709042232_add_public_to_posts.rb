class AddPublicToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :public, :boolean
  end
end

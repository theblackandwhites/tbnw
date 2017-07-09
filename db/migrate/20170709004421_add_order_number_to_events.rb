class AddOrderNumberToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :order_number, :integer
  end
end

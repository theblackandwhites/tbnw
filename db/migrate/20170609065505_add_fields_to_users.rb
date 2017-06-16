class AddFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone, :string
    add_column :users, :address, :text
    add_column :users, :postcode, :string
    add_column :users, :company_name, :string
    add_column :users, :stripe_id, :string
    add_column :users, :stripe_subscription_id, :string
    add_column :users, :credit_card_last_4, :string
    add_column :users, :credit_card_exp_month, :string
    add_column :users, :credit_card_exp_year, :string
    add_column :users, :credit_card_type, :string
  end
end

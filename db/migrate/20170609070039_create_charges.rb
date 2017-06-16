class CreateCharges < ActiveRecord::Migration[5.0]
  def change
    create_table :charges do |t|
      t.references :user, foreign_key: true
      t.decimal :amount
      t.string :credit_card_last_4
      t.string :credit_card_exp_month
      t.string :credit_card_exp_year
      t.string :credit_card_type
      t.string :stripe_charge_id

      t.timestamps
    end
  end
end

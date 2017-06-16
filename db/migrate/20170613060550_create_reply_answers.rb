class CreateReplyAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :reply_answers do |t|
      t.text :body
      t.references :user, foreign_key: true
      t.references :question, foreign_key: true
      t.references :answer, foreign_key: true

      t.timestamps
    end
  end
end

class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :text
      t.string :answer
      t.integer :user_id
      t.string :author_name
      t.integer :author_id
      t.string :author

      t.timestamps
    end
  end
end

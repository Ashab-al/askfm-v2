class AddAuthorNameToQuestion < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :author_name, :string
  end
end

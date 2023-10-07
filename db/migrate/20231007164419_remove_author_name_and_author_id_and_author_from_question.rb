class RemoveAuthorNameAndAuthorIdAndAuthorFromQuestion < ActiveRecord::Migration[6.1]
  def change
    remove_column :questions, :author, :string
    remove_column :questions, :author_id, :integer
    remove_column :questions, :author_name, :string
  end
end

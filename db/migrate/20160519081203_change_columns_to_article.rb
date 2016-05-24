class ChangeColumnsToArticle < ActiveRecord::Migration
  def change
    remove_column :articles, :user, :string
    add_column :articles, :user_id, :integer
  end
end

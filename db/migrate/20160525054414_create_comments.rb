class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :commenter
      t.text :body
      t.integer :user_id
      t.integer :article_id
      t.boolean :approved, default: false

      t.timestamps null: false
    end
  end
end

class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :user, null: false
      t.references :post, null: false

      t.timestamps
    end

    add_foreign_key :comments, :users, column: :user_id
    add_foreign_key :comments, :posts, column: :post_id
  end
end

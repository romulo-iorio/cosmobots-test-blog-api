class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.references :user, null: false

      t.timestamps
    end

    add_foreign_key :posts, :users, column: :user_id
  end
end

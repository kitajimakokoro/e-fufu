class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id,     null: false, foreign_key: true
      t.integer :category_id, null: false, foreign_key: true
      t.text :text,           null: false
      t.timestamps
    end
  end
end

class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :content
      t.references :user, foreign_key: true
      t.references :blog, foreign_key: true

      t.timestamps
    end
    add_index :comments, [:user_id, :created_at]
  end
end

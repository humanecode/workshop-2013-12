class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :group
      t.references :user
      t.date :date
      t.text :body

      t.timestamps
    end
  end
end

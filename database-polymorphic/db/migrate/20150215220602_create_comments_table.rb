class CreateCommentsTable < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :c_object_id
      t.string :c_object_type
      t.timestamps null: false
    end
  end
end

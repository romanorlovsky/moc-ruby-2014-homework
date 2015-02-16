class CreateArticlesTable < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.timestamps null: false
      t.references :author
    end
  end
end

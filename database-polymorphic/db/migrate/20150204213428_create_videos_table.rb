class CreateVideosTable < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.text :description
      t.string :url
      t.timestamps null: false
      t.references :author
    end
  end
end

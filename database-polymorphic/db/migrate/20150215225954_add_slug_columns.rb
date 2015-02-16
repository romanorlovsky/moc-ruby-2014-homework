class AddSlugColumns < ActiveRecord::Migration
  def change
    add_column :videos, :slug, :string
    add_index( :videos, :slug , :unique => true)

    add_column :articles, :slug, :string
    add_index( :articles, :slug , :unique => true)
  end
end

class AddCounterColumns < ActiveRecord::Migration
  def change
    add_column :authors, :videos_count, :integer
    add_column :authors, :articles_count, :integer

    add_column :videos, :comments_count, :integer

    add_column :articles, :comments_count, :integer
  end
end

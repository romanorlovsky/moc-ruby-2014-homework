class CreateAuthorsTable < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name
      t.integer :age, :limit => 2
      t.string :email
      t.string :website
    end
  end
end

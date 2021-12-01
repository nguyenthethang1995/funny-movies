class AddMoreColumnToMovie < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :title, :string
    add_column :movies, :likes, :integer
    add_column :movies, :dislikes, :integer
    add_column :movies, :uid, :string
    add_column :movies, :description, :text
    add_index :movies, :uid
  end
end

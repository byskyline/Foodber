class AddCommentsContToArticles < ActiveRecord::Migration
  def change
    add_column :articles,:last_comment_cratedat, :datetime
  end
end

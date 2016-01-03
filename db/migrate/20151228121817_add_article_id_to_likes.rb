class AddArticleIdToLikes < ActiveRecord::Migration
  def change
    remove_column :likes, :topic_id
    add_column    :likes, :article_id, :integer
    add_index     :likes, :article_id
  end
end

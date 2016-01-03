class AddArticleIdToSubscriptions < ActiveRecord::Migration
  def change
    remove_column :subscriptions, :topic_id
    add_column    :subscriptions, :article_id, :integer
    add_index     :subscriptions, :article_id
  end
end

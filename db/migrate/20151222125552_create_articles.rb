class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :topic
      t.text :content
      t.datetime :publish_date
      t.integer :user_id

      t.timestamps null: false
    end
  end
end

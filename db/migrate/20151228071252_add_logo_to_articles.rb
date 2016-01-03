class AddLogoToArticles < ActiveRecord::Migration


  def change
    add_attachment :articles, :logo
  end
end

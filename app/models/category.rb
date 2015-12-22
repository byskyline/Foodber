class Category < ActiveRecord::Base
	validates_presence_of :title

	has_many :article_categoryships
	has_many :articles, :through => :article_categoryships
end

class Article < ActiveRecord::Base
	validates_presence_of :topic
	belongs_to :user
	has_many :comments

	has_many :article_categoryships
	has_many :categories, :through => :article_categoryships

end

class Article < ActiveRecord::Base
	validates_presence_of :topic
	belongs_to :user
	has_many :comments, :dependent => :destroy

  has_many :likes, :dependent => :destroy
  has_many :liked_users, :through => :likes, :source => :user

  has_many :subscriptions, :dependent => :destroy
  has_many :subscribed_users, :through => :subscriptions, :source => :user

	has_many :article_categoryships
	has_many :categories, :through => :article_categoryships

  has_many :taggings
  has_many :tags, :through => :taggings

  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

  def tag_list
    self.tags.map{ |t| t.name }.join(",")
  end

  def tag_list=(str)
    ids = str.split(",").map do |tag_name|
      tag_name = tag_name.strip.downcase
      tag = Tag.find_by_name( tag_name ) || Tag.create( :name => tag_name )
      tag.id
    end

    self.tag_ids = ids
  end

  def find_my_subscription(u)
     if u
       self.subscriptions.where( :user_id => u.id ).first
     else
       nil
     end
  end

  def url
    "https://warm-lowlands-8026.herokuapp.com" + self.logo.url
  end


  def find_my_like(u)
    if u
      likes.where( :user_id => u.id ).first
    else
      nil
    end
  end


end

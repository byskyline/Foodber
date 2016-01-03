class Admin::ArticlesController < ApplicationController

  before_action :authenticate_user!

  before_action :check_admin

  layout "admin"

  def index
    @articles = Article.all
  end

  def bulk_delete
    Article.destroy_all
    redirect_to articles_path
  end

  def bulk_update
    ids = Array(params[:ids])
    articles = ids.map{ |i| Article.find_by_id(i) }.compact

    if params[:commit] == "Publish"
      articles.each{ |article| article.update( :status => "published" ) }
    elsif params[:commit] == "Delete"
      articles.each{ |article| article.destroy }
    end

    redirect_to articles_url
  end

  protected

    def check_admin
      unless current_user.admin?
         raise ActiveRecord::RecordNotFound

    end
  end
end

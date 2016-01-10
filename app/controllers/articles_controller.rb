class ArticlesController < ApplicationController

	before_action :set_article, :only => [:show]
  before_action :set_my_article, :only => [:edit, :update, :destroy]

	before_action :authenticate_user!, :except => [:index, :show]

  def about
  end

	def index
    if params[:keyword]
      @articles = Article.where( [ "topic like ?", "%#{params[:keyword]}%" ] )
    elsif params[:list]
      @category = Category.find(params[:list])
      @articles = @category.articles
    elsif params[:tag]
      tag = Tag.find_by_name( params[:tag] )
      @articles = tag.articles
    else
      @articles = Article.all
    end


    if params[:order] == 'comments_cont'
      sort_by = 'comments_cont DESC'
    elsif params[:order] == 'comments_cont'
      sory_by = 'lastcomment_crated_at'
    elsif params[:order] == "id"
      sort_by = "id ASC"
    else
      sort_by = "id DESC"
    end

    @articles = @articles.order(sort_by).page(params[:page]).per(5)
	end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(article_params)
		@article.user = current_user

    @article.save

		redirect_to articles_url
	end

	def show
		@page_title= @article.topic
		@comment= Comment.new
		@comments =@article.comments

    unless cookies["view-article-#{@article.id}"]
    cookies["view-article-#{@article.id}"] = "viewed"
     @article.views_count += 1
     @article.save!
    end

	end

	def edit
    @article = current_user.articles.find( params[:id] )
	end

	def update
    @article = current_user.articles.find( params[:id] )
    if params[:_remove_logo] == "1"
    	@article.logo = nil
    end

		if @article.update(article_params)
			flash[:notice] ="編輯成功"
		  redirect_to articles_path( :page => params[:page] )
    else
    	render :action => :index
    end
	end

	def destroy
		if @article.destroy
			flash[:notice] ="刪除成功"
		  redirect_to articles_url( :page => params[:page] )
		end
	end

  # POST /topics/:id/subscribe
  def subscribe
    @article = Article.find( params[:id] )
    @article.subscriptions.create!( :user => current_user )

    redirect_to :back
  end

  def unsubscribe
    @article = Article.find( params[:id] )
    current_user.subscriptions.where( :article_id => @article.id ).destroy_all

    redirect_to :back
  end


	private

	def article_params
		params.require(:article).permit(:topic, :content, :logo,:price,:tag_list, :category_ids => [] )
	end

	def set_article
		@article = Article.find(params[:id])
	end

  def set_my_article
    @article = current_user.articles.find(params[:id])
  end

end

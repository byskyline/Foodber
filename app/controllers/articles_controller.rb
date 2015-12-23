class ArticlesController < ApplicationController
	before_action :set_article, :only=> [:show, :edit, :update, :destroy]
	before_action :authenticate_user!
	def index
		@articles = Article.all
	end

	def new
		@article = Article.new
	end
	
	def create 
		@article = Article.new(article_params)
		@article.user_id = current_user.id
		@article.save
		redirect_to articles_url
	end
	
	def show
		@page_title= @article.topic
		@comment= Comment.new
		@comments =@article.comments
	end

	def edit

	end

	def update
		@article.update(article_params)
		redirect_to articles_path
	end

	def destroy
		@article.destroy
		redirect_to articles_url
	end

	private
	def article_params
		params.require(:article).permit(:topic, :content, :category_ids => [])
	end

	def set_article
		@article=Article.find(params[:id])
	end

end

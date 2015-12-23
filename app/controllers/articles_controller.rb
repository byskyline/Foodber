class ArticlesController < ApplicationController
	before_action :set_article, :only=> [:show, :edit, :update, :destroy]

	def index
		@articles = Article.all
	end

	def new
		@articles = Article.new
	end
	
	def create 
		@articles = Article.new(article_params)
		@articles.save
		redirect_to articles_url
	end
	
	def show
		@page_title= @article.topic

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
		params.require(:article).permit(:topic, :content)
	end

	def set_article
		@article=Article.find(params[:id])
	end

end

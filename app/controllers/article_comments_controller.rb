class ArticleCommentsController < ApplicationController
	before_action :set_article
	def index
		@comments= @article.comments
		@comment=Comment.new
		

	end


	def create
		@comment = @article.comments.build(comment_params)
		@comment.save

		redirect_to article_path(@article)
	end
	


	private
	def comment_params
		params.require(:comment).permit(:content)
	end

	def set_article
		@article= Article.find(params[:article_id])
	end
end

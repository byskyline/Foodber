class ArticleCommentsController < ApplicationController
	before_action :set_article
	def index
		@comments = @article.comments
		@comment  = Comment.new


	end

	def create
		@comment = @article.comments.build(comment_params)
		@comment.user=current_user
    @comment.save
#	if @comment.save
#			@essay.comments
#    @comment_=@last_comment_cratedat

		redirect_to article_path(@article)
	end

	def destroy
		@comment =@article.comments.find(params[:id])
		@comment.destroy
		redirect_to article_path(@article)

	end


	private
	def comment_params
		params.require(:comment).permit(:content)
	end


end

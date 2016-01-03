class LikesController < ApplicationController


  before_action :set_article
  before_action :authenticate_user!, :except => [:index, :show]

  # like
  def create
    Like.create!( :article => @article, :user => current_user )

    redirect_to :back
  end

  # unlike
  def destroy
    like = current_user.likes.find( params[:id] )
    like.destroy

    redirect_to :back
  end

  protected


end

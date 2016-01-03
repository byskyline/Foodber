class Admin::ArticlesController < ApplicationController

  before_action :authenticate_user!

  before_action :check_admin

  layout "admin"

  def index
    @articles = Article.all
  end

  protected

    def check_admin
      unless current_user.admin?
         raise ActiveRecord::RecordNotFound

    end
  end
end

class ApiV1::ArticlesController < ApiController

   # GET /api/v1/topics/:id
  def show
    @article = Article.find(params[:id])
    # show.json.jbuilder
  end

   # GET /api/v1/topics
  def index
    @articles = Article.page( params[:page] ).per(5)
      # index.json.jbuilder
      respond_to do |format|
      format.html
      format.json {
        arr = @articles.map { |t|
          { :id => t.id, :topic => t.topic ,:tags => t.tags ,:price => t.price ,:logo => t.logo }
        }
        render :json => { :data => arr }
      }
      end

  end

end
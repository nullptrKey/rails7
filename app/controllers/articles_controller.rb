class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  # GET /articles or /articles.json
  def index

    #@articles = Article.all
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  # GET /articles/1 or /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
def create
  @article = Article.new(article_params)
  @article.user = current_user
  respond_to do |format|
    if @article.save
      format.html { redirect_to @article, notice: "Article was successfully created." }
    else
      format.html { render :new, status: :unprocessable_entity }
    end
  end
end


  # PATCH/PUT /articles/1 or /articles/1.json
def update
  respond_to do |format|
    if @article.update(article_params)
      format.html { redirect_to @article, notice: "Article was successfully updated." }
    else
      format.html { render :edit, status: :unprocessable_entity }
    end
  end
end


  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy!

    respond_to do |format|
      format.html { redirect_to articles_path, status: :see_other, notice: "Article was successfully destroyed." }
     
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:title, :text) # 把 :article_text 改为 :text
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own articles"
      redirect_to @article
    end
  end

end

class ArticlesController < ApplicationController

  skip_before_action :check_user_log_in
  before_action :get_id, only: [:show, :update, :edit, :destroy]

  def index
    if !logged_in?
      @all_articles = Article.all
    else
      @articles = current_user.articles
      @other_authors_articles = Article.other_authors_articles(current_user.id)
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.new(validate_params)
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def show
    @comments = @article.comments.order(created_at: :desc).first(10)
    @comment = @article.comments.new
  end

  def edit
    unless @article.user_id == current_user.id
      flash[:error] = "you are not authorized to edit this article"
      redirect_to articles_path
    end
  end

  def update
    if @article.update(validate_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def validate_params
    params.require(:article).permit(:title, :description, comments_attributes: [:id, :commenter, :body, :user_id, :approved])
  end

  def get_id
    @article = Article.find(params[:id])
  end

end
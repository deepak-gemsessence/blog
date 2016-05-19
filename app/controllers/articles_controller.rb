class ArticlesController < ApplicationController

  before_action :get_id, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all
    @count = @articles.count
  end

  def new
    @article = Article.new
  end

  def create
    # binding.pry
    @article = Article.new(validate_params)
    if @article.save
      redirect_to @article, alert: "hello"
    else
      render 'new'
    end
  end

  def show
  end

  def edit
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
    params.require(:article).permit(:title, :user, :description)
  end

  def get_id
    @article = Article.find(params[:id])
  end

end

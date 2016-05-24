class ArticlesController < ApplicationController

  skip_before_action :check_user_log_in, except: :all
  before_action :get_id, only: [:show, :edit, :update, :destroy]

  def index
    @articles = current_user.articles.all
  end

  def new
    @article = current_user.articles.new
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
    params.require(:article).permit(:title, :description)
  end

  def get_id
    @article = current_user.articles.find(params[:id])
  end

end

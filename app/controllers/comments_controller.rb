class CommentsController < ApplicationController

  before_action :get_article_id, only: [:new, :create, :show, :update, :destroy, :edit, :approve]
  before_action :current_comment_id, only: [:edit, :update, :destroy, :show, :approve]
  before_action :yet_not_approved, only: :approve
  before_action :show_modifiable, only: [:update, :edit]

  def new
    @comment = @current_article.comments.new
  end

  def create
    params[:comment].merge!({user_id: current_user.id})
    @comment = @current_article.comments.new(validate_params)
    # if Comment.auto_approve_authors_comment(current_user, @current_article)
    #   @comment.update_attribute(:approved, true)
    # end
    @comment.authors_comment(current_user)
    if @comment.save
      redirect_to article_path(@current_article)
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @comment.update(validate_params)
      redirect_to article_path(@current_article)
    else
      render 'edit'
    end
  end

  def destroy
    @comment.destroy
    redirect_to article_path(@current_article)
  end

  def approve
    @comment.update_attribute(:approved, true)
    redirect_to article_path(@current_article)
  end

  private

  def get_article_id
    @current_article = Article.find(params[:article_id])
  end

  def validate_params
    params.require(:comment).permit(:commenter, :body, :user_id, :approved)
  end

  def current_comment_id
    @comment = Comment.find(params[:id])
  end

  def yet_not_approved
    unless @comment.is_article_owner?(current_user)
      redirect_to article_path(@current_article)
    end
  end

  def show_modifiable
    unless @comment.can_modify?(current_user)
      redirect_to article_path(@current_article)
    end
  end

end

class UsersController < ApplicationController
  before_action :finding_user_by_id, only: [:edit, :update, :show, :destroy]
  skip_before_action :check_user_log_in, except: [:index, :show]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(validating_params)
    if @user.save
      session[:current_user_id] = @user.id
      flash[:success] = "Welcome to the Sample App!"
      redirect_to users_path
    else
      flash.now[:error] = "Could not save client, Please check your entries"
      render 'new'
    end
  end

  def show
    flash[:alert] = "Your are on show page"
  end

  def edit
  end

  def update
    if @user.update(validating_updated_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    # if @user == current_user # move this logic in model
    # if User.match_current_user(@user,current_user)

    if @user.match_current_user(current_user)
      @user.destroy
      reset_session
      flash[:notice] = "You have successfully logged out."
      redirect_to welcome_index_path
    else
      @user.destroy
      redirect_to users_path
    end
  end

  def sign_in
    redirect_to users_path if logged_in?
  end

  def authenticate_user
    # user = User.where(username: params[:username], password: params[:password])
    user = User.search_user(params[:username], params[:password])
    if user.present?
      flash[:success] = "Welcome to our web-site"
      session[:current_user_id] = user.first.id
      redirect_to users_path
    else
      redirect_to welcome_index_path
    end
  end

  def sign_out
    reset_session
    flash[:notice] = "You have successfully logged out."
    redirect_to articles_path
  end

  private

  def validating_params
    params.require(:user).permit(:first_name, :last_name, :username, :password, :password_confirmation, :contact)
  end

  def validating_updated_params
    params.require(:user).permit(:first_name, :last_name, :contact)
  end

  def finding_user_by_id
    @user = User.find(params[:id])
  end

end

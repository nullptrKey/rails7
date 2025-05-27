# frozen_string_literal: true
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update,  :destroy]
  before_action :require_user, only: [:edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id # 自动登录
       flash[:notice] = "Welcome to the Alpha Blog #{@user.username}"
       redirect_to articles_path

      # format.html { redirect_to articles_path, notice: "Welcome to the Alpha Blog #{@user.username}" }
    else


      render :new

    end
  end

  def edit
    # @user = User.find(params[:id])
  end
  def update
    # @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Your account information was updated successfully"
      redirect_to @user
    else
      render :edit
    end
  end
  def show
    # @user = User.find(params[:id])
    #@articles = @user.articles
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end
  def index
    #@users = User.all
    @users = User.paginate(page: params[:page], per_page: 5)
  end
  def destroy
    @user = User.find(params[:id])

    @user.destroy
    session[:user_id] = nil
    flash[:notice] = "Account and all articles associated deleted successfully"
    redirect_to users_path
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
  def require_same_user
    if current_user != @user
      flash[:alert] = "You can only edit or delete your own account"
      redirect_to @user
    end
  end

end


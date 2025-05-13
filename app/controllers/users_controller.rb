# frozen_string_literal: true
class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
       flash[:notice] = "Welcome to the Alpha Blog #{@user.username}"
       redirect_to articles_path

      # format.html { redirect_to articles_path, notice: "Welcome to the Alpha Blog #{@user.username}" }
    else


      render :new

    end
  end

  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Your account information was updated successfully"
      redirect_to articles_path
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end


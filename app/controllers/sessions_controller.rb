# frozen_string_literal: true
class SessionsController <  ApplicationController
  def new

  end

  def create
    #Rails.logger.info "Params: #{params.inspect}"
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "You have successfully logged in"
      redirect_to user_path(user)
    else
      Rails.logger.info("Setting flash alert")
      flash.now[:alert] = "There was something wrong with your login information"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have logged out"
    redirect_to root_path
  end



end

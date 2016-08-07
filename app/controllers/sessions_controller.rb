class SessionsController < ApplicationController
  def new
    session[:forwarding_url] = request.referer
    redirect_to google_sign_in_path
  end

  def create
    begin
      @user = User.from_omniauth(request.env['omniauth.auth'])
      log_in @user
      remember @user
      flash[:success] = "Welcome, #{@user.name}!"
    rescue
      flash[:warning] = "There was an error while trying to authenticate you..."
    end
    redirect_to session[:forwarding_url] || root_path
  end

  def destroy
    log_out
    forget @user
    flash[:info] = "Successfully logged out"
    redirect_to request.referer || root_path
  end

  def failure
    log_out
    flash[:info] = "There was an error while trying to authenticate you..."
    redirect_to request.referer || root_path
  end
end

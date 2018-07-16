class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless current_user? @user
  end

  private

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t ".pleaselogin"
    redirect_to login_url
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "static_pages.home.usernotfound"
    redirect_to root_path
  end
end

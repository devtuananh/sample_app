class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :verify_admin, only: :destroy
  before_action :load_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.page(params[:page]).per Settings.show_limit.show_10
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "activation.check_email"
      redirect_to root_url
    else
      render :new
    end
  end

  def show
    @microposts = @user.microposts.page(params[:page]).per Settings.show_limit.show_10
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".prupdate"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".success"
      redirect_to users_path
    else
      flash[:danger] = t "static_pages.home.usernotfound"
      redirect_to users_path
    end
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "static_pages.home.usernotfound"
    redirect_to root_path
  end

  def verify_admin
    return if current_user.admin?
    redirect_to root_url
  end

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end
end

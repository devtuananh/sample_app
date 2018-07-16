class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find_by id: params[:followed_id]
    if @user
      current_user.follow @user
      respond_to do |format|
        format.html{redirect_to @user}
        format.js
      end
    else
      flash[:danger] = t "users.user_not_exist"
      redirect_to following_path current_user
    end
  end

  def destroy
    relationship = Relationship.find_by id: params[:id]
    if relationship
      @user = relationship.followed
      current_user.unfollow @user
      respond_to do |format|
        format.html{redirect_to @user}
        format.js
      end
    else
      flash[:danger] = t "users.user_not_exist"
      redirect_to following_path current_user
    end
  end
end

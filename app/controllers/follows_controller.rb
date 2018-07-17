class FollowsController < ApplicationController
  before_action :logged_in_user
  before_action :load_user

  def following
    @title = t "users.flow_user.following"
    @users = @user.following.page(params[:page]).per Settings.show_limit.show_10
    render "users/show_follow"
  end

  def followers
    @title = t "users.flow_user.followers"
    @users = @user.followers.page(params[:page]).per Settings.show_limit.show_10
    render "users/show_follow"
  end
end

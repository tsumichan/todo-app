class UsersController < ApplicationController
  # before_action :login_check
  helper_method :logged_in?
  def index
    @users = User.all
  end
end

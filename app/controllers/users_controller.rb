class UsersController < ApplicationController
  before_action :logged_in?, :is_admin?

  def index
    @users = User.all
  end
end

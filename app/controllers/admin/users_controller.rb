class Admin::UsersController < ApplicationController
  before_action :reject_common_access

  def index
    @users = User.all.page(params[:page])
  end
end

class Admin::UsersController < ApplicationController
  before_action :reject_common_access, if: -> { !current_user&.admin? }

  def index
    @users = User.all.page(params[:page])
  end
end

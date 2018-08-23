class UsersController < ApplicationController
  before_action :not_access_to_admin_page, if: -> { !current_user&.admin? }

  def index
    @users = User.all.page(params[:page])
  end
end

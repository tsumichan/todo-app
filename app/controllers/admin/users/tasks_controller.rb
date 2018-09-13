class Admin::Users::TasksController < ApplicationController
  before_action :reject_visitor_access, :reject_common_access

  def index
    @tasks = User.find(params[:user_id]).tasks.page(params[:page])
  end
end

class Admin::Users::TasksController < ApplicationController
  before_action :reject_visitor_access, :reject_common_access

  def index
    user = User.find(params[:user_id])
    @tasks = Task.where(user_id: user.id).page(params[:page])
  end
end

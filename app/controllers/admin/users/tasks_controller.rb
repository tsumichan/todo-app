class Admin::Users::TasksController < ApplicationController
  before_action :reject_visitor_access, :reject_common_access

  def index
    @tasks = Task.where(user_id: params[:user_id]).page(params[:page])
  end
end

class Admin::TasksController < ApplicationController
  before_action :reject_visitor_access, :reject_common_access
  def show
    @tasks = Task.where(user_id: params[:id]).page(params[:page])
  end
end

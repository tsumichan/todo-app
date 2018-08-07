class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @statuses = Task.statuses.map { |k, v| [t("enums.task.status.#{k}"), v]}
    @sorts = [t('views.task.sort.created_at'), 0], [t('views.task.sort.due_at'), 1], [t('views.task.sort.priority_desc'), 2], [t('views.task.sort.priority_asc'), 3]
    @tasks = Task.includes(:user).search_by_title(params[:search]).search_by_status(params[:status]).order_by(params[:sort]).page(params[:page])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to root_path, flash: { success: t('views.task.message.created') }
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to root_path, flash: { success: t('views.task.message.updated') }
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to root_path, flash: { success: t('views.task.message.deleted') }
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :due_at, :status, :priority, :user_id)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end

class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    word = params[:search]
    status = params[:status]
    sort = params[:sort]
    @statuses = Task.statuses.map { |k, v| [t("enums.task.status.#{k}"), v]}
    @sorts = Task.sorts.map { |k, v| [t("enums.task.sort.#{k}"), v]}
    @tasks = Task.search(word).search_status(status).sort_by_due_at(sort)
  end
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to root_path, flash: { success: t('view.task.message.created')}
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
      redirect_to root_path, flash: { success: t('view.task.message.updated')}
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to root_path, flash: { success: t('view.task.message.deleted')}
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :due_at, :status, :priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end

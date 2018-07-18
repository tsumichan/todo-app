class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @statuses = Task.statuses
    @tasks = if params[:sort_by] == 'due_at'
               Task.order(due_at: :asc)
             elsif params[:search].present?
               word = params[:search]
               Task.search(word)
             elsif params[:status].present?
               status = params[:status]
               Task.search_status(status)
             else
               Task.order(created_at: :desc)
             end
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

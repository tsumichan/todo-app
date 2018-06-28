class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to root_path
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
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to root_path
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :due_at, :status, :priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end

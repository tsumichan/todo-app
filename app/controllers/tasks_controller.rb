class TasksController < ApplicationController
  before_action :get_task, only: [:show, :edit, :update]

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

  private

  def task_params
    params.require(:task).permit(:title, :description, :due_at, :status, :priority)
  end

  def get_task
    @task = Task.find(params[:id])
  end
end

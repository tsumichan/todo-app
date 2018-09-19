class Setting::LabelsController < ApplicationController
  before_action :reject_visitor_access
  before_action :set_label, only: [:edit, :update, :destroy]

  def index
    @labels = Label.all
  end
  
  def new
    @label = Label.new
  end

  def create
    @label = Label.new(label_params)
    if @label.save
      redirect_to setting_labels_path, flash: { success: t('views.task.message.created') }
    else
      render :new
    end
  end
  private

  def label_params
    params.require(:label).permit(:name)
  end

  def set_label
    @label = Label.find(params[:id])
  end
end

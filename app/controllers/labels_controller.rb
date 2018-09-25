class LabelsController < ApplicationController
  before_action :reject_visitor_access
  before_action :set_label, only: [:edit, :update, :destroy]

  def index
    @labels = @current_user.labels.page(params[:page])
  end

  def new
    @label = Label.new
  end

  def create
    @label = @current_user.labels.build(label_params)
    if @label.save
      redirect_to labels_path, flash: { success: t('views.label.message.created') }
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @label.update(label_params)
      redirect_to labels_path, flash: { success: t('views.label.message.updated') }
    else
      render :edit
    end
  end

  def destroy
    @label.destroy
      redirect_to labels_path, flash: { success: t('views.label.message.deleted') }
  end

  private

  def label_params
    params.require(:label).permit(:name)
  end

  def set_label
    @label = Label.find(params[:id])
  end
end

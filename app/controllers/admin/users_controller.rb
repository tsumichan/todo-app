class Admin::UsersController < ApplicationController
  before_action :reject_visitor_access, :render_404_if_common_accessed

  def index
    @users = User.all.page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, flash: { success: t('views.user.message.created') }
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, flash: { success: t('views.user.message.updated') }
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to admin_users_path, flash: { success: t('views.user.message.deleted') }
    else
      redirect_to admin_users_path, flash: { danger: t('views.user.message.last_admin') }
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :role)
  end
end

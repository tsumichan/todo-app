class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: params[:session][:name].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      redirect_to root_path, flash: { success: t('views.user.message.log_in_success') }
    else
      flash[:danger] = t('views.user.message.log_in_failed')
      render :new
    end
  end

  def destroy
    log_out
    redirect_to login_path, flash: { success: t('views.user.message.log_out_success') }
  end
end

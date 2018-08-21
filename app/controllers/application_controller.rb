class ApplicationController < ActionController::Base
  include Session
  helper_method :is_current_user?
  before_action :set_locale

  private
    def set_locale
      I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales)
    end

    def is_admin?
      redirect_to root_path, flash: { warning: '管理者以外はアクセスできません' } unless current_user.admin?
    end

    def logged_in?
      redirect_to login_path, flash: { warning: t('views.user.message.require_login') } unless is_current_user?
    end
end

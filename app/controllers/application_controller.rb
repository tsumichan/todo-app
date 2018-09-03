class ApplicationController < ActionController::Base
  include Session
  helper_method :logged_in?
  before_action :set_locale

  private
    def set_locale
      I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales)
    end

    def reject_common_access
      redirect_to root_path, flash: { warning: '管理者以外はアクセスできません' } unless current_user&.admin?
    end

    def reject_visitor_access
      redirect_to login_path, flash: { warning: t('views.user.message.require_login') } unless logged_in?
    end
end

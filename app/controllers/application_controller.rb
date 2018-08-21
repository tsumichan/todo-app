class ApplicationController < ActionController::Base
  include Session
  helper_method :is_current_user?, :is_admin?
  before_action :set_locale

  private
    def set_locale
      I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales)
    end

    def is_admin?
      current_user.role == 1
    rescue => e
      redirect_to login_path, flash: { warning: t('views.user.message.require_login') }
    end
end

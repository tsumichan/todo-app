class ApplicationController < ActionController::Base
  include Session
  helper_method :logged_in?
  before_action :set_locale

  private
    def set_locale
      I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales)
    end
end

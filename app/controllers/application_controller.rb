class ApplicationController < ActionController::Base
  rescue_from StandardError, with: :render_500 unless Rails.env.development?
  rescue_from ActiveRecord::RecordNotFound, with: :render_404 unless Rails.env.development?
  rescue_from ActionController::RoutingError, with: :render_404 unless Rails.env.development?
  include Session
  helper_method :logged_in?
  before_action :set_locale

  def render_404(e = nil)
    if e
      logger.error e
      logger.error e.backtrace.join("\n")
    end
    render file: Rails.root.join('public/404.html'), status: 404, layout: false, content_type: 'text/html'
  end

  def render_500(e = nil)
    if e
      logger.error e
      logger.error e.backtrace.join("\n")
    end
    render file: Rails.root.join('public/500.html'), status: 500, layout: false, content_type: 'text/html'
  end

  private
  
  def set_locale
    I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales)
  end

  def render_404_if_common_accessed
    render file: Rails.root.join('public/404.html'), status: 404, layout: false, content_type: 'text/html' unless current_user&.admin?
  end

  def reject_visitor_access
    redirect_to login_path, flash: { warning: t('views.user.message.require_login') } unless logged_in?
  end
end

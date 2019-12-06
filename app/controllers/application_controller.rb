class ApplicationController < ActionController::Base
  before_action :set_paper_trail_whodunnit
  before_action :load_current_user

  private

  def load_current_user
    @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def check_authentication
    render_error unless @current_user
  end

  def admin_permission
    render_error unless @current_user&.admin?
  end

  def render_error(error = 'Доступ запрещен', options = {})
    @error = error
    status = options[:status] || 403

    render 'error', status: status
  end

  def user_for_paper_trail
    session[:user_id]
  end
end

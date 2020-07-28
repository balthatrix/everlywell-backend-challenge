class ApplicationController < ActionController::Base

  before_action :check_authorized
  helper_method :current_member
  helper_method :logged_in?

  def current_member
    Member.find_by(id: session[:member_id])
  end

  def logged_in?
    !current_member.nil?
  end

  def check_authorized
    redirect_to '/welcome' unless logged_in?
  end
end

class ApplicationController < ActionController::Base
  include ApplicationHelper

  before_action :set_user
  before_action :require_signed_in

  private

  def set_user
    @user = User.find(session[:user_id]) if user_signed_in?
  end

  def require_signed_in
    return redirect_to root_path unless user_signed_in?
  end
end

class ApplicationController < ActionController::Base
  include ApplicationHelper

  before_action :require_signed_in, :set_user

  private

  def set_user
    @user = User.find(session[:user_id]) if user_signed_in?
  end

  def require_signed_in
    unless user_signed_in?
      flash[:danger] = "You need to signed in to do that"
      return redirect_to root_path
    end
  end
end

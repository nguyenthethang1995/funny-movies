class SessionsController < ApplicationController
  skip_before_action :require_signed_in, only: :create

  after_action :fetch_youtube_metadata, only: :create

  def create
    user = User.find_or_initialize_by(email: params[:email])

    if user.new_record?
      user.password = params[:password]
      user.save
    end

    user.authenticate(params[:password]) ? flash[:success] = "Login sucess" : flash[:danger] = "wrong email or password"

    session[:user_id] = user.id if flash.to_h.has_key?("success")
    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Log out sucess"
    redirect_to root_path
  end

  private

  def fetch_youtube_metadata
    UpdateYoutubeMetadata.perform_now if user_signed_in?
  end
end

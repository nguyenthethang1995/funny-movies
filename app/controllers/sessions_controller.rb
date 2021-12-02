class SessionsController < ApplicationController
  skip_before_action :require_signed_in

  after_action :fetch_youtube_metadata, only: :create

  def create
    user = User.find_by_email(params[:email])

    if user && !user.authenticate(params[:password])
      flash[:danger] = "wrong email or password"
      return redirect_to root_path
    end
    
    if !user
      user = User.create!(email: params[:email], password: params[:password])
    end

    session[:user_id] = user.id

    flash[:success] = "Login sucess"
    redirect_to root_path
  rescue => ex
    flash[:danger] = ex
    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def fetch_youtube_metadata
    UpdateYoutubeMetadata.perform_now
  end
end

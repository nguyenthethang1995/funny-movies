class MoviesController < ApplicationController
  skip_before_action :require_signed_in, only: :index

  def index
    @movies = Movie.latest.page params[:page]
  end

  def share; end

  def create
    Movie.create!(link: params[:link], user_id: session[:user_id])
    flash[:success] = "Movie shared"
    redirect_to root_path
  rescue => ex
    flash[:danger] = ex
    redirect_to root_path
  end
end

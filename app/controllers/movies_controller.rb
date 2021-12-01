class MoviesController < ApplicationController
  skip_before_action :require_signed_in, only: :index

  before_action :set_movie, only: %i[thumbs_up thumbs_down]

  after_action :fetch_new_data_and_redirect, only: %i[thumbs_down thumbs_up]

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

  private

  def set_movie
    @movie = Movie.find_by(id: params[:id])
  end
end

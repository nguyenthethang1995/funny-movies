class MoviesController < ApplicationController
  skip_before_action :require_signed_in, only: :index

  def index
    @movies = Movie.latest.page params[:page]
  end

  def share; end

  def create
    movie = @user.movies.build(link: params[:link])

    movie.save ? flash[:success] = "Movie shared" : flash[:danger] = movie.errors.full_messages.to_sentence
    redirect_to root_path
  end
end

class UpdateYoutubeMetadata < ApplicationJob
  queue_as :default

  def perform
    Movie.all.each do |movie|
      movie.fetch_youtube_metadata.save
    end
  end
end

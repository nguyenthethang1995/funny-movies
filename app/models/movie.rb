class Movie < ApplicationRecord
  YOUTUBE_DISPLAY_URL_PREFIX = 'https://www.youtube.com/embed'.freeze

  belongs_to :user

  before_save :fetch_youtube_metadata

  validates :link, presence: true, uniqueness: true, format: /\A.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/i.freeze

  scope :latest, -> { order(created_at: :desc) }
  
  def fetch_youtube_metadata
    video = Yt::Video.new url: self.link
    self.uid = video.id
    self.title = video.title
    self.likes = video.like_count
    self.dislikes = video.dislike_count
    self.description = video.description
    self
  rescue Yt::Errors::NoItems
    self.title = ""
  end

  def youtube_video_url
    "#{YOUTUBE_DISPLAY_URL_PREFIX}/#{uid}"
  end

  def title
    self[:title] || "This video has no title"
  end

  def description
    self[:description] || "This video has no description"
  end
end

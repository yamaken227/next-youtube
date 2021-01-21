class Post < ApplicationRecord
  is_impressionable
  belongs_to :user
  has_many :messages

  with_options presence: true do
    validates :title
    validates :highlights
    validates :video_url
  end

#  VALID_YOUTUBE_URL = /(\Ahttps:\/\/www\.youtube\.com\/watch\?v=)+[\w]{11}\z/
  VALID_YOUTUBE_URL = /\A(https\:\/\/)?(www\.)?(youtube\.com\/watch\?v=|youtu\.be\/)+[\S]{11}\z/
  validates_format_of :video_url, with: VALID_YOUTUBE_URL, message: 'はYouTubeの動画のURLのみご利用いただけます'

end

class Post < ApplicationRecord
  belongs_to :user
  
  with_options presence: true do
    validates :title
    validates :highlights
    validates :video_url
  end
end

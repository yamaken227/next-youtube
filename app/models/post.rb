class Post < ApplicationRecord
  is_impressionable
  belongs_to :user
  has_many :messages
  
  with_options presence: true do
    validates :title
    validates :highlights
    validates :video_url
  end
end

class Message < ApplicationRecord
  belongs_to :post
  validates :message, presence: true
end

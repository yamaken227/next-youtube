class Message < ApplicationRecord
  belongs_to :post
#  エラーメッセージが出ない 一旦保留  
#  validates :message, length: { maximum:200 }
end

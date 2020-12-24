class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :channel_name
    validates :subscribers_num
    validates :channel_url
    validates :what_channel
  end

  validates :subscribers_num,numericality: {
    with: /\A[0-9]+\z/, message: '半角数字のみ入力可能です'
  }
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: '文字と数字の両方を含めてください'
end
